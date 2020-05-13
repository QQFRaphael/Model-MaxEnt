load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

path = "../../results-extract/"
scenes = (/"ME",  "ML",  "SE",  "SL",  "VSE",  "WE",  "WL",  "neural"/)

do ii=0,dimsizes(scenes)-1
scene = scenes(ii)

f = addfile(path+scene+".nc", "r")

data = f->Band1

data = where(data.lt.0.6, 0, 1)

system("rm -rf "+scene+".nc")
out = addfile(scene+".nc", "c")
out->Band1 = data
system("gdal_translate "+scene+".nc "+scene+".asc")
system("rm -rf *.xml")
end do
