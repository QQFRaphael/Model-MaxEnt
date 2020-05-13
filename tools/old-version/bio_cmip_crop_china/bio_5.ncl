f = addfile("bio_5.nc", "r")

tmp = getfilevartypes(f,"Band1") 

lats = f->lat
lons = f->lon

lat_idx = ind(lats.ge.17.0.and.lats.le.54.7)
lon_idx = ind(lons.ge.72.4.and.lons.le.136.4)

if (tmp.eq."short") then
    Band1 = short2flt(f->Band1(lat_idx,lon_idx))/10.0
else if (tmp.eq."byte") then
    Band1 = byte2flt(f->Band1(lat_idx,lon_idx))/10.0
else if (tmp.eq."double") then
    Band1 = f->Band1(lat_idx,lon_idx)/10.0
else
    print("=================error!!!=================")
end if
end if 
end if

f2 = addfile("../../example_grid.nc","r")
lat = f2->lat
lon = f2->lon 

newdata = linint2_Wrap(lons(lon_idx), lats(lat_idx), Band1, True, lon, lat, 0)

system("rm -rf bio_5-china.nc")
out = addfile("bio_5-china.nc","c")
out->Band1 = newdata
out->lat = lat
out->lon = lon

system("gdal_translate -of aaigrid netcdf:bio_5-china.nc:Band1 bio_5.asc")
system("rm -rf *.xml bio_5-china.nc")
