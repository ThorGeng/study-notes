import pdfplumber
import os
import sys,fitz
from pyzbar.pyzbar import decode
from PIL import Image


def get_qrcode(path):
    pdfDoc = fitz.open(path)
    page = pdfDoc[0]
    rotate  =int(0)    
    zoom_x = 3.0 
    zoom_y = 3.0
    mat = fitz.Matrix(zoom_x, zoom_y).preRotate(rotate)
    rect = page.rect
    mp  =rect.tl +(rect.br - rect.tl) *1/5
    clip  =fitz.Rect(rect.tl,mp)
               
    pix = page.getPixmap(matrix=mat, alpha=False,clip = clip)
        
    img  =Image.frombytes("RGB",(pix.width,pix.height),pix.samples)
    barcodes = decode(img)
       
    for barcode in barcodes:
        url = barcode.data.decode("utf-8")
        return url


if __name__=='__main__':
    base_path = os.getcwd()
    filenames =  os.listdir(base_path)

    for filename in filenames:
        full_path = os.path.join(base_path, filename)
        if full_path.endswith('.pdf'):
            result = get_qrcode(full_path)
            results=list(result.split(','))
            new_full_name = base_path +"\\" +results[2] +"_"+results[3]+".pdf"
            
            try:
                os.rename(full_path,new_full_name)
            except Exception as e:
                if e.args[0]==17:
                    fname,fename = os.path.splitext(new_full_name)
                    os.rename(full_path,fname+"-副本"+fename)
            
        else:
            continue

