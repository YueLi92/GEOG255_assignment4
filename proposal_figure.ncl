;***************************************
;* Code to draw the precipitation & circulation
;* over the Amazon & Sahel regions
;* by Yue Li 2019.10.10
;***************************************
;---Load the NCL file that contains the gsn_* functions used below.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

;------ 1st functionto calculate the sum of water variable
undef("water_sum")
function water_sum (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric,area:numeric, filename1:string, scaleFactor:numeric)
begin
  
  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  dimz = dimsizes(area)
  var_mth = new((/30,dimz(0),dimz(1)/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = var&lat
    tmp&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------

;------ 1st functionto calculate the sum of water variable
undef("water_sum_cru")
function water_sum_cru (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,360,720/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------
;------ 1st functionto calculate the sum of water variable
undef("water_sum_cnfoc")
function water_sum_cnfoc (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var!0 = "time"
  var&time = ttt&time
  var!1 = "lat"
  var&lat = ttt&lat
  var!2 = "lon"
  var&lon = ttt&lon
  yr = 1982
  var_mth = new((/30,400,700/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era")
function water_sum_era (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  var@_FillValue = 1e+20
  yr = 1982
  var_mth = new((/30,91,180/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = var&lat
    tmp&lon = var&lon
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------
undef("water_sum_era2")
function water_sum_era2 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var@_FillValue = 1e+20
  kt = -32767*ttt@scale_factor+ttt@add_offset
  var = where(var .le. kt, var@_FillValue, var)
  yr = 1982
  var_mth = new((/30,241,480/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp1 = dim_sum_n_Wrap(var((yr-yearref)*12*4+(beginmth-1)*4+1-1:(yr-yearref)*12*4+endmth*4-1,:,:),0)

    tmp = tmp1/(endmth-beginmth+1)
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = ttt&latitude
    tmp&lon = ttt&longitude
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era5_avg")
function water_sum_era5_avg (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  ;var@_FillValue = 1e+20
  if(beginmth .eq. 12)
    var(2,:,:) = var(11,:,:)
    tmp = dim_avg_n_Wrap(var(0:2,:,:),0)
  else
    tmp = dim_avg_n_Wrap(var(beginmth-1:endmth-1,:,:),0)
  end if

  tmp = tmp*scaleFactor
  return ([/tmp/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era5_vert_avg")
function water_sum_era5_vert_avg (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  ;var@_FillValue = 1e+20
  if(beginmth .eq. 12)
    var(2,:,:,:) = var(11,:,:,:)
    tmp = dim_avg_n_Wrap(var(0:2,7,:,:),0) ; set pres level to 7 as '850hPa'
  else
    tmp = dim_avg_n_Wrap(var(beginmth-1:endmth-1,7,:,:),0)
  end if

  tmp = tmp*scaleFactor
  return ([/tmp/])
end


undef("water_sum_era_uv10")
function water_sum_era_uv10 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var@_FillValue = 1e+20
  kt = -32767*ttt@scale_factor+ttt@add_offset
  var = where(var .le. kt, var@_FillValue, var)
  yr = 1982
  var_mth = new((/30,241,480/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_sum_n_Wrap(var((yr-yearref)*12+(beginmth-1):(yr-yearref)*12+endmth-1,:,:),0)
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = ttt&latitude
    tmp&lon = ttt&longitude
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    delete(tmp)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_merra")
function water_sum_merra (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,361,540/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp2 = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp2 = tmp2*scaleFactor
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&YDim
    tmp2&lon = var&XDim
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_ncep")
function water_sum_ncep (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,94,192/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp2 = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    tmp2 = tmp2*scaleFactor
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&lat
    tmp2&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_ncep2")
function water_sum_ncep2 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,73,144/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:,:),0)
    tmp = tmp*scaleFactor
    tmp2 = rm_single_dims(tmp)
    ;print(tmp2)
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&lat
    tmp2&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end


undef("vector_plot")
function vector_plot(nb:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res_vc                            = res
  res_vc@vcGlyphStyle               = "LineArrow"
  res_vc@vcLineArrowThicknessF      = 0.8
  res_vc@vcMinDistanceF             = 0.04
  res_vc@vcRefLengthF               = 0.05

;;wind barb resources don't apply
;;      res_vc@vcGlyphStyle               = "WindBarb"
;;      res_vc@vcWindBarbLineThicknessF   = 5
;;      res_vc@vcWindBarbColor            = "Gray40"

  res_vc@vcRefAnnoOn               = True
  res_vc@vcRefMagnitudeF           = 1.5
  res_vc@vcRefAnnoString1          = "1.5m/s"
  res_vc@vcRefAnnoSide             = "Top"
  res_vc@vcRefAnnoString2On        = False
  res_vc@vcRefAnnoPerimOn          = False
  res_vc@vcRefAnnoOrthogonalPosF   = -0.05
  res_vc@vcRefAnnoParallelPosF     = 1
  res_vc@vcRefAnnoBackgroundColor  = "White"
  res_vc@vcVectorDrawOrder         = "PostDraw"
  res_vc@gsnRightString            = ""
  res_vc@vcLineArrowColor          = "Red"
  res_vc@vcGlyphStyle              = "CurlyVector"
  return(res_vc)
end

;-------2 nd function to create original plot
undef("pattern_plot")
function pattern_plot (nb:string, varunit:string, PaletteColor:string, levelmode:string,levels:numeric, varname:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@gsnCenterString = "";Timescale_name
  ;res@gsnRightString = varunit
  res@gsnLeftString = varname
  res@gsnLeftStringFontHeightF = 0.014
  res@gsnLeftStringFontColor = "black"
  res@gsnPaperOrientation = "portrait"

  ;res@gsnRightString = "Jan_1982_Veg3"
  res@cnFillPalette = PaletteColor
  res@cnFillOn = True
  res@tiMainString = "";Mainstring_name
  res@cnLevelSelectionMode = levelmode
  res@cnLevels = levels
  res@cnLinesOn = False

  res@vpWidthF = 0.6
  res@vpHeightF = 0.3

  res@mpFillOn = False
  res@mpOutlineOn = True
  res@mpGeophysicalLineColor = "Gray21"
  res@mpMaxLatF = 37 
  res@mpMinLatF = 25
  res@mpMaxLonF = -74
  res@mpMinLonF = -95
  ;res@tmXBValues = (/-90,-60,-30,0,30,60,90,120,150/)
  ;res@tmXBLabels = (/"90~S~o~N~W","60~S~o~N~W","30~S~o~N~W","0~S~o~N~","30~S~o~N~E","60~S~o~N~E","90~S~o~N~E","120~S~o~N~E","150~S~o~N~E"/)
  ;res@tmYLValues = (/-30,0,30/)
  ;res@tmYLLabels = (/"30~S~o~N~S","0~S~o~N~","30~S~o~N~N"/)
  res@tmXBLabelFontHeightF = 0.014
  res@tmYLLabelFontHeightF = 0.014

  res@mpDataBaseVersion = "Ncarg4_1"
  res@mpDataSetName = "Earth..4"
  ;res@mpOutlineSpecifiers = (/"China","Taiwan"/)
  res@mpGeophysicalLineThicknessF = 1
  res@mpNationalLineThicknessF    = 1

  res@pmLabelBarWidthF = 0.5
  res@pmLabelBarHeightF = 0.05
  res@pmLabelBarOrthogonalPosF = 0.15

  res@lbLabelBarOn 	= False
  res@tmXBOn            = False
  res@tmYLOn            = False
  res@tmXTOn            = False
  res@tmYROn            = False
  res@cnLineLabelInterval   = 0
  res@lbPerimOn         = False
  res@lbBoxLinesOn = False

  res@lbTitleString    = varunit
  res@lbOrientation = "horizontal"
  res@lbTitleFontHeightF = 0.014
  res@lbLabelFontHeightF = 0.014
  res@lbTitlePosition = "Bottom"
  ;res@lbTitleAngleF = 90.
  ;res@lbTitleDirection = "Bottom"
  ;res@lbBoxEndCapStyle = "TriangleBothEnds"
  res@tmXBOn            = False
  res@tmYLOn            = False
  res@tmXTOn            = False
  res@tmYROn            = False
  res@cnFillMode       = "RasterFill" 

  ;res22 = True
  ;res22@gsnDraw = False
  ;res22@gsnFrame = False
  ;res22@cnFillOpacityF = 0.3
  ;res22@cnFillOn = False
  ;res22@cnLinesOn = False
  ;res22@cnInfoLabelOn = False
  ;if(option.eq.2) then
  ;      map = gsn_csm_contour_map(wks,rc_lai_S3,res)
  ;      map_contour = gsn_csm_contour(wks,tval2_lai_S3,res22)
  ;      map_contour = ShadeLtGtContour(map_contour,-1.701,4,1.701,3)
  ;      overlay(map,map_contour)
  ;else
  ;       map = gsn_csm_contour_map(wks,var_mth,res)
  ;print("ok")
  ;end if
  ;if(nb .eq. "e") then
  ;  res@gsnAddCyclic = False
  ;end if
  return (res)
;draw(mmap)
;frame(wks)
end

undef("pattern_plot2")
function pattern_plot2 (nb:string, varunit:string, PaletteColor:string, levelmode:string,levels:numeric, varname:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@gsnPaperOrientation = "portrait"

  res@cnFillPalette = PaletteColor
  res@cnFillOn = False
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnLevels = levels
  res@cnLinesOn = True
  res@cnLineColor = "green"
  res@cnLineLabelDensityF = 3.0

  res@vpWidthF = 0.6
  res@vpHeightF = 0.3

  res@mpFillOn = False

  if(nb .eq. "e") then
    res@gsnAddCyclic = False
  end if
  return (res)
;draw(mmap)
;frame(wks)
end

undef("get_color")
function get_color (value:numeric)
begin
  if(value .le. -1) then
    color=(/165., 0., 33./)
  else if(value .ge. -1 .and. value .lt. -0.8) then
    color=(/246., 38., 52./)
  else if(value .ge. -0.8 .and. value .lt. -0.6) then
    color=(/255., 61., 61./)
  else if(value .ge. -0.6 .and. value .lt. -0.4) then
    color=(/255., 172., 117./)
  else if(value .ge. -0.4 .and. value .lt. -0.2) then
    color=(/255., 214., 153./)
  else if(value .ge. -0.2 .and. value .lt. 0) then
    color=(/255., 255., 233./)
  else if(value .ge. 0 .and. value .lt. 0.2) then
    color=(/233., 255., 255./)
  else if(value .ge. 0.2 .and. value .lt. 0.4) then
    color=(/153., 233., 255./)
  else if(value .ge. 0.4 .and. value .lt. 0.6) then
    color=(/117., 211., 255./)
  else if(value .ge. 0.6 .and. value .lt. 0.8) then
    color=(/61., 135., 255./)
  else if(value .ge. 0.8 .and. value .lt. 1) then
    color=(/40., 86., 255./)
  else
    color=(/35., 0., 216./)
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  color = color/255
  return(color)
end

undef("Biomass_prediction")
function Biomass_prediction (xtp:numeric, xt:numeric, mat_ama:numeric, mat_con:numeric, mat_asa:numeric, flag:numeric, mi:numeric)
begin
  if(mi .ge. 6) then
    vi = mi -1
  else
    vi = mi
  end if
  yt = new((/180,360/),double)

  if(flag .eq. 1) then ; TREECOVER
    tp1 = xt(66:113,275:330)   ; SouthAmerica, lat:-23 ~ 23; 275 ~ 330
    yt(66:113,275:330) = mat_ama(6, vi)*tp1
    tp21 = xt(66:113,340:359) ; West Africa
    yt(66:113,340:359) = mat_con(6, vi)*tp21
    tp22 = xt(66:113,0:49) ; Mid-East Africa
    yt(66:113,0:49) = mat_con(6, vi)*tp22
    tp3 = xt(66:113,70:160); Southeast Asia
    yt(66:113,70:160) = mat_asa(6,vi)*tp3 
  else if(flag .eq. 3); MAT
    tp1 = xt(66:113,275:330)   ; SouthAmerica, lat:-23 ~ 23; 275 ~ 330
    yt(66:113,275:330) = mat_ama(5, vi)*tp1
    tp21 = xt(66:113,340:359) ; West Africa
    yt(66:113,340:359) = mat_con(5, vi)*tp21
    tp22 = xt(66:113,0:49) ; Mid-East Africa
    yt(66:113,0:49) = mat_con(5, vi)*tp22   
    tp3 = xt(66:113,70:160); Southeast Asia
    yt(66:113,70:160) = mat_asa(5,vi)*tp3
  else ; MAP
    tp1 = xt(66:113,275:330)   ; SouthAmerica, lat:-23 ~ 23; 275 ~ 330
    tp1p= xtp(66:113,275:330)
    yt1p = mat_ama(0,vi)*exp(-( ((tp1p-mat_ama(1,vi))/mat_ama(2,vi))^2  ) )-mat_ama(3,vi)
    yt1p = where(tp1p .ge. mat_ama(1,vi), mat_ama(0,vi)-mat_ama(3,vi), yt1p)
    yt1d = mat_ama(0,vi)*exp(-( ((tp1p+tp1-mat_ama(1,vi))/mat_ama(2,vi))^2  ) )-mat_ama(3,vi) 
    yt1d = where(tp1p+tp1 .ge. mat_ama(1,vi), mat_ama(0,vi)-mat_ama(3,vi), yt1d)
    yt(66:113,275:330) = (yt1d - yt1p)*mat_ama(4,vi)

    tp2 = xt(66:113,340:359)   ; Africa
    tp2p= xtp(66:113,340:359)
    yt2p = mat_con(0,vi)*exp(-( ((tp2p-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt2p = where(tp2p .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt2p)
    yt2d = mat_con(0,vi)*exp(-( ((tp2p+tp2-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt2d = where(tp2p+tp2 .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt2d)
    yt(66:113,340:359) = (yt2d - yt2p)*mat_con(4,vi) 

    tp3 = xt(66:113,0:49)   ; Africa
    tp3p= xtp(66:113,0:49)
    yt3p = mat_con(0,vi)*exp(-( ((tp3p-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt3p = where(tp3p .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt3p)
    yt3d = mat_con(0,vi)*exp(-( ((tp3p+tp3-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt3d = where(tp3p+tp3 .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt3d)
    yt(66:113,0:49) = (yt3d - yt3p)*mat_con(4,vi)

    tp4 = xt(66:113,70:160)   ; Southeast Asia
    tp4p= xtp(66:113,70:160)
    yt4p = mat_asa(0,vi)*exp(-( ((tp4p-mat_asa(1,vi))/mat_asa(2,vi))^2  ) )-mat_asa(3,vi)
    yt4p = where(tp4p .ge. mat_asa(1,vi), mat_asa(0,vi)-mat_asa(3,vi), yt4p)
    yt4d = mat_asa(0,vi)*exp(-( ((tp4p+tp4-mat_asa(1,vi))/mat_asa(2,vi))^2  ) )-mat_asa(3,vi)
    yt4d = where(tp4p+tp4 .ge. mat_asa(1,vi), mat_asa(0,vi)-mat_asa(3,vi), yt4d)
    yt(66:113,70:160) = (yt4d - yt4p)*mat_asa(4,vi)

  end if
  end if
  return(yt)
end

;------------------------ function labelbar
undef("attach_labelbar")
function attach_labelbar(wks,plot,labels,colors)
local lbres, vph, vpw, nboxes
begin
  nboxes = dimsizes(labels)
  getvalues plot                      ; Get plot size for use in
    "vpHeightF" : vph                 ; creating labelbar.
    "vpWidthF"  : vpw
  end getvalues

  lbres                    = True          ; labelbar only resources
  lbres@lbAutoManage       = False          ; Necessary to control sizes
  lbres@lbPerimOn          = False
  ;lbres@cnLabelBarEndStyle = "IncludeOuterBoxes"
  lbres@lbLabelPosition    = "Right"
  lbres@lbLabelAlignment   = "InteriorEdges"
  lbres@lbOrientation 	   = "Horizontal"
  lbres@vpWidthF           = 0.95 *  vpw     ; labelbar width
  lbres@vpHeightF          = 0.16 * vph           ; labelbar height
  lbres@lbLabelOffset      = 0.03
  lbres@lbFillColors       = colors
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.01          ; font height. default is small
  lbres@lbBoxLinesOn       = True

  lbid = gsn_create_labelbar(wks,nboxes,labels,lbres)
;
; Now, create some annotation resources indicating how we want to
; attach the labelbar to the plot.
;                                                                 
  amres                = True
  amres@amParallelPosF = 0     ; Move away from plot
  amres@amOrthogonalPosF = 0.68
  annoid = gsn_add_annotation(plot,lbid,amres)

  return(annoid)
end
;--------------------------------

procedure add_shp_outlines(wks,plot,shp_filename)
local lnres
begin
;---Resources for polyline
  lnres                  = True
  lnres@gsLineColor      = "gray"
  lnres@gsLineThicknessF = 1.0            ; 3x thickness

  plot@lines = gsn_add_shapefile_polylines(wks, plot, shp_filename, lnres)
end


;=================================================    main function    =============================================
begin
;***************************** user define ******************************
var_name2 = "precip"

scaleFactor2 = 86400; for LE

units1 = "%"; for PRE
units2 = "~S~o~N~C"
units3 = "%"
units4 = "MgC ha~S~-1~N~"
units5 = "%"

cmapp = read_colormap_file("MPL_PRGn")
cmap = read_colormap_file("cmp_flux")
colortable1 = cmapp
colortable2 = cmap
cmap2 = read_colormap_file("MPL_YlGnBu")
colortable3 = cmap2
cmap4 = read_colormap_file("MPL_BrBG")
colortable4 = cmap4
cmap5 = read_colormap_file("MPL_PuOr")
colortable5 = cmap5(::-1,:)
;levelmode = "AutomaticLevels"
levelmode = "ExplicitLevels"

levels1 = fspan(-20, 20,21)
levels2 = fspan(-2.4,2.4,25)
levels3 = ispan(5,95,5)
levels4 = fspan(-80., 80.,21)
levels5 = fspan(-20., 20., 21)
;*******************************************************************************
f = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp1_rcp26/treecover_diff_2041-2060.nc","r")
tct1 = f->treecover_diff
ff = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp1_rcp26/treecover_diff_2081-2100.nc","r")
tct2 = ff->treecover_diff
printVarSummary(tct1)
tct1!0 = "lat"
tct1&lat = f->lat
tct1!1 = "lon"
tct1&lon = f->lon
tct2!0 = "lat"
tct2&lat = ff->lat
tct2!1 = "lon"
tct2&lon = ff->lon
tct1&lat@units = "degrees_north"
tct1&lon@units = "degrees_east"
tct2&lat@units = "degrees_north"
tct2&lon@units = "degrees_east"

f = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp2_rcp45/treecover_diff_2041-2060.nc","r")
tct11 = f->treecover_diff
ff = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp2_rcp45/treecover_diff_2081-2100.nc","r")
tct22 = ff->treecover_diff
printVarSummary(tct1)
tct11!0 = "lat"
tct11&lat = f->lat
tct11!1 = "lon"
tct11&lon = f->lon
tct22!0 = "lat"
tct22&lat = ff->lat
tct22!1 = "lon"
tct22&lon = ff->lon
tct11&lat@units = "degrees_north"
tct11&lon@units = "degrees_east"
tct22&lat@units = "degrees_north"
tct22&lon@units = "degrees_east"

f = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp3_rcp7/treecover_diff_2041-2060.nc","r")
tct111 = f->treecover_diff
ff = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp3_rcp7/treecover_diff_2081-2100.nc","r")
tct222 = ff->treecover_diff
printVarSummary(tct1)
tct111!0 = "lat"
tct111&lat = f->lat
tct111!1 = "lon"
tct111&lon = f->lon
tct222!0 = "lat"
tct222&lat = ff->lat
tct222!1 = "lon"
tct222&lon = ff->lon
tct111&lat@units = "degrees_north"
tct111&lon@units = "degrees_east"
tct222&lat@units = "degrees_north"
tct222&lon@units = "degrees_east"

f = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp5_rcp85/treecover_diff_2041-2060.nc","r")
tct1111 = f->treecover_diff
ff = addfile("/data1/geog/yli/LUH/Forest_map_LUH2v2f/ssp5_rcp85/treecover_diff_2081-2100.nc","r")
tct2222 = ff->treecover_diff
printVarSummary(tct1)
tct1111!0 = "lat"
tct1111&lat = f->lat
tct1111!1 = "lon"
tct1111&lon = f->lon
tct2222!0 = "lat"
tct2222&lat = ff->lat
tct2222!1 = "lon"
tct2222&lon = ff->lon
tct1111&lat@units = "degrees_north"
tct1111&lon@units = "degrees_east"
tct2222&lat@units = "degrees_north"
tct2222&lon@units = "degrees_east"
; -------------------------------------------------------------------draw the plot
graphname = "fut_forest.LUH.ssp"
wks_type          = "pdf"
wks_type@wkWidth  = 1450          ; Make X11 window larger. Default
wks_type@wkHeight = 900
wks = gsn_open_wks(wks_type,graphname);

mmap = new(8,graphic)

;-------------------------------------- contour
res22 = True
res22@gsnDraw = False
res22@gsnFrame = False
res22@cnFillOpacityF = 0.1
res22@cnFillOn = False
res22@cnInfoLabelOn = False
res22@cnLineLabelPlacementMode = "constant"
res22@cnLineDashSegLenF = 0.1
res22@cnLevelSelectionMode = "ManualLevels"
res22@cnMinLevelValF = -0.05
res22@cnMaxLevelValF = 1.95
res22@cnLevelSpacingF = 1
res22@cnLevelFlags = "LineOnly"
res22@gsnLeftString = ""
res22@gsnRightString = ""
res22@tmXBOn = False
res22@gsnContourPosLineDashPattern = 0 
res22@cnLineColor = "springgreen"
res22@cnLabelMasking = True
res22@gsnContourZeroLineThicknessF = 2.5

;resp                  = True                      ; polyline mods desired
;resp@gsLineColor      = "Gray"                     ; color of lines
;resp@gsLineThicknessF = 1.0                       ; thickness of lines
;res22 = True
;res22@gsnDraw = False
;res22@gsnFrame = False
;res22@cnFillOpacityF = 0.1
;res22@cnFillOn = False
;res22@cnLinesOn = False
;res22@cnInfoLabelOn = False
;res22@cnLineLabelPlacementMode = "constant"
;res22@cnLineDashSegLenF = 0.1
;res22@cnLevelSelectionMode = "ManualLevels"
;res22@cnMinLevelValF = 0.6
;res22@cnMaxLevelValF = 1
;res22@cnLevelSpacingF = 0.05 

;-----------------------------------------------draw the map -------------------------------------------
nb = "a"
result1 = pattern_plot (nb, units1, colortable1, levelmode,levels1,"SSP1-2.6 (by 2041-2060)")
res = result1 
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map = gsn_csm_contour_map(wks,tct1,res)

nb = "b"
result1 = pattern_plot (nb, units1, colortable1,levelmode,levels1,"SSP1-2.6 (by 2081-2100)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map2 = gsn_csm_contour_map(wks,tct2,res)

nb = "a"
result1 = pattern_plot (nb, units1, colortable1, levelmode,levels1,"SSP2-4.5 (by 2041-2060)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map3 = gsn_csm_contour_map(wks,tct11,res)

nb = "b"
result1 = pattern_plot (nb, units1, colortable1,levelmode,levels1,"SSP2-4.5 (by 2081-2100)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map4 = gsn_csm_contour_map(wks,tct22,res)

nb = "a"
result1 = pattern_plot (nb, units1, colortable1, levelmode,levels1,"SSP3-7.0 (by 2041-2060)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map5 = gsn_csm_contour_map(wks,tct111,res)

nb = "b"
result1 = pattern_plot (nb, units1, colortable1,levelmode,levels1,"SSP3-7.0 (by 2081-2100)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map6 = gsn_csm_contour_map(wks,tct222,res)

nb = "a"
result1 = pattern_plot (nb, units1, colortable1, levelmode,levels1,"SSP5-8.5 (by 2041-2060)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map7 = gsn_csm_contour_map(wks,tct1111,res)

nb = "b"
result1 = pattern_plot (nb, units1, colortable1,levelmode,levels1,"SSP5-8.5 (by 2081-2100)")
res = result1
res@lbLabelBarOn = False
;res@mpMaxLatF = 23
;res@mpMinLatF = -23
;res@mpMaxLonF = 170
;res@mpMinLonF = -90
map8 = gsn_csm_contour_map(wks,tct2222,res)

mmap(0) = map
mmap(1) = map2
mmap(4) = map3
mmap(5) = map4
;mmap(2) = map5
;mmap(6) = map6
;mmap(3) = map7
;mmap(7) = map8
pres = True
pres@gsnPanelLabelBar = True
pres@lbPerimOn         = False
pres@lbBoxLinesOn = False
pres@pmLabelBarWidthF   = 0.4    ; label bar width
gsn_panel(wks,mmap,(/2,4/),pres)


end
