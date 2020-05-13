f = addfile("wc2.0_bio_5m_19.nc", "r")

Band1 = f->Band1
lats = f->lat
lons = f->lon

lat_idx = ind(lats.ge.0.0.and.lats.le.60.0)
lon_idx = ind(lons.ge.60.0.and.lons.le.150.0)

Band1China = Band1(lat_idx,lon_idx)

out = addfile("bio_19.nc","c")
out->Band1 = Band1China
out->lat = lats(lat_idx)
out->lon = lons(lon_idx)