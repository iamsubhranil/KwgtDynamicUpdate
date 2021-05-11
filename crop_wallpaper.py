import sys
try:
    from PIL import Image
except ImportError:
    print("This module requires PIL! Do 'pip install pillow' first!")
    sys.exit(1)

def positive_integer(source):
    try:
        x = int(source.strip())
        if x <= 0:
            return False
        return x
    except:
        return False

def crop_image(img_details):
    # first, sort by input image name, so that we can open
    # the image one time, and do all the operations
    img_details.sort(key=lambda x: x[5])
    rootimage = None
    oldinputname = None
    for img in img_details:
        outname, posx, posy, dimw, dimh, inputname = img
        print("Cropping '%s' (%d, %d, %d, %d).." % (outname, posx, posy, dimw, dimh))
        if inputname != oldinputname:
            try:
                rootimage = Image.open(inputname)
            except Exception as e:
                print("Unable to open image '%s'! (err: %s)" % (inputname, str(e)))
                continue
        try:
            rootimage.crop((posx, posy, posx + dimw, posy + dimh)).save(outname)
        except Exception as e:
            print("Unable to crop and save '%s'! (err: %s)" % (outname, str(e)))

def main():
    crop_details = "crop_details.txt" # by default, look for this
    if len(sys.argv) > 1:
        crop_details = sys.argv[1]
    try:
        # list of tuples of the format (outname, posx, posy, dimw, dimh, inputname)
        img_details = []
        with open(crop_details, "r") as f:
            lines = f.readlines()
            for lineno, line in enumerate(lines):
                if line.startswith("#"): # ignore comment lines
                    continue
                parts = line.strip().split(" ")
                if len(parts) != 6:
                    print("Ignoring invalid line #%d: '%s' (err: contains unexpected number of parts)" % (lineno + 1, line))
                    continue
                outname = parts[0].strip()
                posx = positive_integer(parts[1])
                posy = positive_integer(parts[2])
                dimw = positive_integer(parts[3])
                dimh = positive_integer(parts[4])
                if posx == False or posy == False or dimw == False or dimh == False:
                    print("Ignoring invalid line #%d: '%s' (err: not all pos/dim values are positive integers)" % (lineno + 1, line))
                    continue
                inputname = parts[5].strip()
                img_details.append((outname, posx, posy, dimw, dimh, inputname))
        if len(img_details) > 0:
            crop_image(img_details)
            print("Cropping completed!")
        else:
            print("Nothing to crop!")
    except Exception as e:
        print("Unable to parse '%s' (err: '%s')!" % (crop_details, str(e)))

if __name__ == "__main__":
    main()
