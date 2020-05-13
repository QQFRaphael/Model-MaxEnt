load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

path = "../../results-extract/"
scene = "neural"
index = "(h) "

f = addfile(path+scene+".nc", "r")

data = f->Band1

wks = gsn_open_wks("eps",scene)         

res                     = True  

res@gsnDraw=False
res@gsnFrame=False


res@gsnAddCyclic = False        
res@gsnMaximize = True   
res@cnFillOn            = True             
res@cnFillMode          = "RasterFill"     
res@cnLinesOn           = False           

res@cnLevelSelectionMode = "ExplicitLevels"    
res@cnLevels=(/0.2,0.4,0.6/)
res@cnFillColors=(/"green4","yellow2","orange","red"/)

res@mpLimitMode = "LatLon"
res@mpMinLatF = 16
res@mpMaxLatF = 35
res@mpMinLonF = 100
res@mpMaxLonF = 124

res@mpFillOn = True
res@mpLandFillColor   = "white"
res@mpPerimOn = False
res@mpOutlineOn = False

res@mpGridAndLimbOn     = True
res@mpGridSpacingF      = 5
res@mpGridLineDashPattern       = 2
res@mpGridLineThicknessF = 5

res@gsnLeftString = ""
res@gsnRightString = ""
res@lbLabelBarOn = False
res@cnLineLabelsOn = False

plot = gsn_csm_contour_map(wks, data, res)

draw(plot)
frame(wks)