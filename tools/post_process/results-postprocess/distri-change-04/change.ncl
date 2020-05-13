load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

scene1 = "WL"
scene2 = "neural"
path = "../make-binary-SDM-04/"

f1 = addfile(path+scene1+".nc", "r")
f2 = addfile(path+scene2+".nc", "r")

data1 = f1->Band1
data2 = f2->Band1

data3 = data1
nx = dimsizes(data1(0,:))
ny = dimsizes(data1(:,0))

do ix = 0, nx-1
do iy = 0, ny-1

tmp1 = data1(iy,ix)
tmp2 = data2(iy,ix)

if (ismissing(tmp1).and.ismissing(tmp2)) then
    tmp3 = tmp1
else if (tmp1.eq.0.and.tmp2.eq.0) then
    tmp3 = 0
else if (tmp1.eq.1.and.tmp2.eq.1) then
    tmp3 = 1
else if (tmp1.eq.1.and.tmp2.eq.0) then
    tmp3 = 2
else if (tmp1.eq.0.and.tmp2.eq.1) then
    tmp3 = -1
else
    tmp3 = data1@_FillValue
end if
end if
end if
end if
end if

data3(iy,ix)=tmp3
delete(tmp3)
end do
end do

wks = gsn_open_wks("eps",scene1+"-"+scene2)         

res                     = True  

res@gsnDraw=False
res@gsnFrame=False


res@gsnAddCyclic = False        
res@gsnMaximize = True   
res@cnFillOn            = True             
res@cnFillMode          = "RasterFill"     
res@cnLinesOn           = False           

res@cnLevelSelectionMode = "ExplicitLevels"    
res@cnLevels=(/-1,0,1,2/)
res@cnFillColors=(/"white","blue","gray","green4","red"/)

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

plot = gsn_csm_contour_map(wks, data3, res)

draw(plot)
frame(wks)

system("rm -rf "+scene1+"-"+scene2+".nc")
out = addfile(scene1+"-"+scene2+".nc", "c")
out->Band1 = data3

system("gdal_translate " + scene1+"-"+scene2+".nc "+ scene1+"-"+scene2+".asc ")
system("rm -rf *.xml")

data1 = where(data3.ne.-1,data3@_FillValue,1)
data2 = where(data3.ne.2,data3@_FillValue,1)
print(scene1+"-"+scene2+" 1 grids: "+dim_sum_n_Wrap(ndtooned(data1),0))
print(scene1+"-"+scene2+" 2 grids: "+dim_sum_n_Wrap(ndtooned(data2),0))
