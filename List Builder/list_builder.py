import sys
import math
import os
import hashlib
import shutil

done = "Error: No games found."
total = 0
count = 0
pattern_1 = [b'\x01', b'\x0D']
pattern_2 = [b'\x3B', b'\x31']

def count_iso(folder, game_path):
    global total
    for image in os.listdir(game_path + folder):
        if image.endswith(".ISO") or image.endswith(".iso"):
            total += 1

def process_iso(folder, game_path, xeb_path, game_list, create_vmc):
    global total, count, done

    for image in os.listdir(game_path + folder):
        if image.endswith(".ISO") or image.endswith(".iso"):
            print(f"{math.floor((count * 100) / total)}% complete")
            print(f"Processing {image}")
            index = 0
            string = ""
            with open(game_path + folder + "/" + image, "rb") as file:
                while (byte := file.read(1)):
                    if len(string) < 4:
                        if index == 2:
                            string += byte.decode('utf-8', errors='ignore')
                        elif byte == pattern_1[index]:
                            index += 1
                        else:
                            string = ""
                            index = 0
                    elif len(string) == 4:
                        index = 0
                        if byte == b'\x5F':
                            string += byte.decode('utf-8', errors='ignore')
                        else:
                            string = ""
                    elif len(string) < 8:
                        string += byte.decode('utf-8', errors='ignore')
                    elif len(string) == 8:
                        if byte == b'\x2E':
                            string += byte.decode('utf-8', errors='ignore')
                        else:
                            string = ""
                    elif len(string) < 11:
                        string += byte.decode('utf-8', errors='ignore')
                    elif len(string) == 11:
                        if byte == pattern_2[index]:
                            index += 1
                            if index == 2:
                                break
                        else:
                            string = ""
                            index = 0

                count += 1

            if len(string) == 11:
                print(f"Found title ID {string}")

                vmc = f"/VMC/{string}_0.bin"
                with open("vmc_groups.list", "r") as f:
                    lines = f.readlines()

                for line in lines:
                    line = line.strip()
                    if line[:4] == "XEBP":
                        size = "8"
                        group = line
                    elif len(line) < 5:
                        size = line[:2]
                    elif line == string:
                        vmc = f"/VMC/{group}_0.bin"
                        break

                if create_vmc:
                    if vmc != f"/VMC/{string}_0.bin" and not os.path.isfile(game_path + f"/VMC/{string}_0.bin"):
                        print(f"Creating VMC /VMC/{string}_0.bin (8MB)")
                        shutil.copyfile(".vmc/8.bin", game_path + f"/VMC/{string}_0.bin")
                    if not os.path.isfile(game_path + vmc):
                        print(f"Creating VMC {vmc} ({size}MB)")
                        shutil.copyfile(f".vmc/{size}.bin", game_path + vmc)
                    print(f"Assigned {string} to {vmc}")
                elif not os.path.isfile(game_path + vmc):
                    vmc = "0000000000000000000000"

                with open(xeb_path + game_list, "a") as output:
                    output.write(f"{string} {folder}/{image} {vmc}\n")

    done = "Done!"

def error_message():
    print('Error: Missing argument(s).')
    print('Usage: list_builder.py <drive type>[-h -u -m -i] <path/to/games> <path/to/XEBPLUS/installation> <create VMCs>[-vmc]')
    print('')
    print('Examples:')
    print('list_builder.py -h E:\\PS2 D:\\')
    print('list_builder.py -u D:\\ D:\\ -vmc')
    print('list_builder.py -m \'/media/SD Card\' \'/media/USB Drive\'')
    print('')
    quit()

def main(arg1, arg2, arg3, arg4):
    if arg1 and arg2 and arg3:
        drive = arg1
        game_path = arg2
        xeb_path = arg3
        create_vmc = arg4 == "-vmc"
    else:
        error_message()

    print('')
    print('This program will create the list of installed PS2 games that is required by the XEB+ neutrino loader plugin.')
    print('Additonal documentation can be found at https://github.com/sync-on-luma/xebplus-neutrino-loader-plugin')

    if drive.lower() == "-h":
        game_list = 'neutrinoHDD.list'
    elif drive.lower() == "-u":
        game_list = 'neutrinoUSB.list'
    elif drive.lower() == "-m":
        game_list = 'neutrinoMX4.list'
    elif drive.lower() == "-c":
        game_list = 'neutrinoMMCE.list'
    elif drive.lower() == "-i":
        game_list = 'neutrinoILINK.list'
    else:
        print('Error: Invalid drive type')
        quit()

    if not os.path.isdir(xeb_path + '/XEBPLUS'):
        print(f'\nError: Cannot find XEBPLUS folder at {xeb_path}')
        quit()
    if not os.path.isdir(xeb_path + '/XEBPLUS/CFG/neutrinoLauncher'):
        os.mkdir(xeb_path + '/XEBPLUS/CFG/neutrinoLauncher')
    xeb_path = xeb_path + '/XEBPLUS/CFG/neutrinoLauncher/'
    print('')

    if os.path.isfile(xeb_path + game_list):
        os.remove(xeb_path + game_list)

    if create_vmc and not os.path.isfile(".vmc/8.bin"):
        print("Warning: VMC.bin not found. VMCs will not be created.")
        create_vmc = False

    if os.path.isdir(game_path + '/CD'):
        count_iso('/CD', game_path)
    else:
        print(f'CD folder not found at {game_path}')
    if os.path.isdir(game_path + '/DVD'):
        count_iso('/DVD', game_path)
    else:
        print(f'DVD folder not found at {game_path}')

    if create_vmc and not os.path.isdir(game_path + '/VMC'):
        os.mkdir(game_path + '/VMC')

    if os.path.isdir(game_path + '/DVD'):
        process_iso('/DVD', game_path, xeb_path, game_list, create_vmc)
    if os.path.isdir(game_path + '/CD'):
        process_iso('/CD', game_path, xeb_path, game_list, create_vmc)

    if os.path.isfile(xeb_path + game_list):
        with open(xeb_path + game_list, "r") as output:
            hash = hashlib.md5(output.read().encode("utf-8")).hexdigest()
        with open(xeb_path + game_list, "a") as output:
            output.write(hash)

    print(done)
    print('')

if __name__ == '__main__':
    if len(sys.argv) == 5:
        main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
    elif len(sys.argv) == 4:
        main(sys.argv[1], sys.argv[2], sys.argv[3], "")
    else:
        error_message()
