import sys
import math
import os.path
import hashlib

done = "Error: No games found."
total = 0
count = 0
pattern_1 = [b'\x01', b'\x0D']
pattern_2 = [b'\x3B', b'\x31']


def count_iso(folder):
    global total
    for image in os.listdir(game_path+folder):
        if image.endswith(".ISO") or image.endswith(".iso"):
            total = total + 1

def process_iso(folder):
    global total
    global count
    global pattern
    global done

    for image in os.listdir(game_path+folder):
        if image.endswith(".ISO") or image.endswith(".iso"):
            print(math.floor((count*100)/total),'% complete')
            print('Processing', image)
            index = 0
            string = ""
            with open(game_path + folder + "/" + image, "rb") as file:
                while (byte := file.read(1)):

                    if len(string) < 4:
                        if index == 2:
                            string = string + byte.decode('utf-8', errors='ignore')
                        elif byte == pattern_1[index]:
                            index = index + 1
                        else:
                            string = ""
                            index = 0
                    elif len(string) == 4:
                        index = 0
                        if byte == b'\x5F':
                            string = string + byte.decode('utf-8', errors='ignore')
                        else:
                            string =""
                    elif len(string) < 8:
                        string = string + byte.decode('utf-8', errors='ignore')
                    elif len(string) == 8:
                        if byte == b'\x2E':
                            string = string + byte.decode('utf-8', errors='ignore')
                        else:
                            string =""
                    elif len(string) < 11:
                        string = string + byte.decode('utf-8', errors='ignore')
                    elif len(string) == 11:
                        if byte == pattern_2[index]:
                            index = index + 1
                            if index == 2:
                                break
                        else:
                            string = ""
                            index = 0

                count = count + 1

            if  len(string) == 11:
                print('Found title ID '+string)

                output = open(xeb_path+game_list, "a")
                output.write(string+" "+folder+"/"+image+"\n")
                output.close()
    done = "Done!"

def main(arg1, arg2, arg3):
    if arg1 and arg2 and arg3:
        global drive
        global game_path
        global xeb_path
        drive = arg1
        game_path = arg2
        xeb_path = arg3
    else:
        print('Error: Missing argument(s).')
        print('Usage: list_builder.py <drive type>[-h -u -m] <path/to/games> <path/to/XEBPLUS/installation>')
        print('')
        print('Examples:')
        print('list_builder.py -h E:\\PS2 D:\\')
        print('list_builder.py -u D:\\ D:\\')
        print('list_builder.py -m \'/media/SD Card\' \'/media/USB Drive\'')
        print('')
        quit()

    print('')
    print('This program will create the list of installed PS2 games that is required by the XEB+ neutrino loader plugin.')
    print('Additonal documentation can be found at https://github.com/sync-on-luma/xebplus-neutrino-loader-plugin')

    global game_list

    if drive == "-H" or drive == "-h":
        game_list = 'neutrinoHDD.list'
    elif drive == "-U" or drive == "-u":
        game_list = 'neutrinoUSB.list'
    elif drive == "-M" or drive == "-m":
        game_list = 'neutrinoMX4.list'
    else:
        print('Error: Invalid drive type')
        quit()

    if os.path.isdir(xeb_path+'/XEBPLUS') == False:
        print('\nError: Cannot find XEBPLUS folder at '+xeb_path)
        quit()
    if os.path.isdir(xeb_path+'/XEBPLUS/CFG/neutrinoLauncher') == False:
        os.mkdir(xeb_path+'/XEBPLUS/CFG/neutrinoLauncher')
    xeb_path = xeb_path+'/XEBPLUS/CFG/neutrinoLauncher/'
    print('')

    if os.path.isfile(xeb_path+game_list):
        os.remove(xeb_path+game_list)

    if os.path.isdir(game_path+'/CD'):
        count_iso('/CD')
    else:
        print('CD folder not found at '+game_path)
    if os.path.isdir(game_path+'/DVD'):
        count_iso('/DVD')
    else:
        print('DVD folder not found at '+game_path)
    if os.path.isdir(game_path+'/DVD'):
        process_iso('/DVD')
    if os.path.isdir(game_path+'/CD'):
        process_iso('/CD')

    if os.path.isfile(xeb_path+game_list):
        output = open(xeb_path+game_list, "r")
        hash = hashlib.md5(output.read().encode("utf-8")).hexdigest()
        output.close()
        output = open(xeb_path+game_list, "a")
        output.write(hash)
        output.close()

    #print('Processing',(count*100)/total,'%')
    print(done)
    print('')

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2], sys.argv[3])
