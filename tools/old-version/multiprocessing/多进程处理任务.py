import os
import time
import multiprocessing

def worker(model):
    t_start = time.time()
    print("begin to process %s" % model)

    os.chdir(model)

    allbios = os.popen("ls bio*.nc").read().split("\n")[0:19]
    unitchange = ['bio_1.nc','bio_2.nc','bio_4.nc','bio_5.nc','bio_6.nc','bio_7.nc','bio_8.nc','bio_9.nc','bio_10.nc','bio_11.nc']


    for bio in allbios:
        prefix = os.path.splitext(bio)[0]

        os.system("sed -i \"1s/^.*.$/f = addfile(\\\"%s\\\", \\\"r\\\")/\" %s.ncl" % (bio,model))
        os.system("sed -i \"29s/^.*.$/system(\\\"rm -rf %s-china.nc\\\")/\" %s.ncl" % (prefix,model))
        os.system("sed -i \"30s/^.*.$/out = addfile(\\\"%s-china.nc\\\",\\\"c\\\")/\" %s.ncl" % (prefix,model))

        if bio in unitchange:
            os.system("sed -i \"12s/^.*.$/    Band1 = short2flt(f->Band1(lat_idx,lon_idx))\/10.0/\" %s.ncl" % model)
            os.system("sed -i \"14s/^.*.$/    Band1 = byte2flt(f->Band1(lat_idx,lon_idx))\/10.0/\" %s.ncl" % model)
            os.system("sed -i \"16s/^.*.$/    Band1 = f->Band1(lat_idx,lon_idx)\/10.0/\" %s.ncl" % model)
        else:
            os.system("sed -i \"12s/^.*.$/    Band1 = short2flt(f->Band1(lat_idx,lon_idx))/\" %s.ncl" % model)
            os.system("sed -i \"14s/^.*.$/    Band1 = byte2flt(f->Band1(lat_idx,lon_idx))/\" %s.ncl" % model)
            os.system("sed -i \"16s/^.*.$/    Band1 = f->Band1(lat_idx,lon_idx)/\" %s.ncl" % model)

        os.system('ncl %s.ncl' % model)
        os.system('gdal_translate -of aaigrid netcdf:%s-china.nc:Band1 %s.asc' % (prefix, prefix))
        os.system('rm -rf *.xml *-china.nc')
        print("%s/%s complete" % (model,bio))
    t_stop = time.time()
    print("Model: %s complete, exit !!! Use %0.2f" % (model,t_stop-t_start))

    os.chdir(os.path.dirname(os.getcwd())) # L9 change the working dir, need to go back for following process...

if __name__ == "__main__":
    timestart = time.time()
    pool = multiprocessing.Pool(processes = 6)

    models = os.popen("ls -d */").read().split("\n")
    models = models[0:len(models)-1]
    #models = ['bcc_csm1_1_m_rcp2_6_2030s','bcc_csm1_1_m_rcp2_6_2050s','bcc_csm1_1_m_rcp2_6_2070s','bcc_csm1_1_m_rcp4_5_2030s','bcc_csm1_1_m_rcp4_5_2050s','bcc_csm1_1_m_rcp4_5_2070s','bcc_csm1_1_m_rcp6_0_2030s','bcc_csm1_1_m_rcp6_0_2050s','bcc_csm1_1_m_rcp6_0_2070s','bcc_csm1_1_m_rcp8_5_2030s','bcc_csm1_1_m_rcp8_5_2050s','bcc_csm1_1_m_rcp8_5_2070s','bcc_csm1_1_rcp2_6_2030s','bcc_csm1_1_rcp2_6_2050s','bcc_csm1_1_rcp2_6_2070s','bcc_csm1_1_rcp4_5_2030s','bcc_csm1_1_rcp4_5_2050s','bcc_csm1_1_rcp4_5_2070s','bcc_csm1_1_rcp6_0_2030s','bcc_csm1_1_rcp6_0_2050s','bcc_csm1_1_rcp6_0_2070s','bcc_csm1_1_rcp8_5_2030s','bcc_csm1_1_rcp8_5_2050s','bcc_csm1_1_rcp8_5_2070s']
    for model in models:
        pool.apply_async(worker, (model, ))   
        #pool.apply_async(worker, (model[:-1], ))   

    pool.close()
    pool.join() 
    timestop = time.time() 
    print("All subprocesses are complete after %0.2f" % (timestop-timestart))
