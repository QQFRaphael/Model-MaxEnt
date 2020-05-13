f = addfile("soil_ph.nc", "r")

Band1 = f->Band1
lats = f->lat
lons = f->lon

f2 = addfile("../example_grid.nc","r")
lat = f2->lat
lon = f2->lon 

newdata = linint2_Wrap(lons, lats, Band1, True, lon, lat, 0)

out = addfile("soil_ph-china.nc","c")
out->Band1 = newdata
out->lat = lat
out->lon = lon