f = addfile("56464_UVB6_Sum_of_UV-B_Radiation_of_Lowest_Quarter.asc.nc", "r")

Band1 = f->Band1
lats = f->lat
lons = f->lon

f2 = addfile("../example_grid.nc","r")
lat = f2->lat
lon = f2->lon 

newdata = linint2_Wrap(lons, lats, Band1, True, lon, lat, 0)

out = addfile("UVB6.nc","c")
out->Band1 = newdata
out->lat = lat
out->lon = lon