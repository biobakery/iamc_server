#=
fixes labeling mistake:
    wrong_id => right_id

include("batch2fix.jl")
=#

corrections = Dict(
    "JIA00002"=>"JIA00002",
    "OAS00004"=>"JIA00032",
    "JIA00003"=>"BHM00074",
    "JIA00004"=>"JIA00047",
    "JIA00015"=>"JIA00053",
    "JIA00016"=>"BHM00139",
    "OAS00013"=>"BHM00140",
    "JIA00001"=>"NCL00020",
    "JIA00026"=>"OAS00004",
    "JIA00027"=>"JIA00019",
    "OAS00014"=>"BHM00113",
    "JIA00031"=>"JIA00048",
    "JIA00032"=>"OAS00008",
    "JIA00019"=>"JIA00055",
    "JIA00025"=>"JIA00054",
    "JIA00028"=>"BHM00126",
    "OAS00001"=>"JIA00003",
    "OAS00005"=>"JIA00025",
    "ORA00001"=>"BHM00114",
    "JIA00034"=>"JIA00050",
    "JIA00035"=>"OAS00011",
    "JIA00037"=>"JIA00057",
    "JIA00043"=>"MUS00011",
    "JIA00046"=>"NCL00008",
    "BHM00074"=>"JIA00004",
    "BHM00113"=>"JIA00028",
    "BHM00114"=>"BHM00116",
    "BHM00116"=>"OAS00012",
    "BHM00117"=>"OAS00015",
    "BHM00118"=>"JIA00059",
    "BHM00127"=>"NCL00016",
    "BHM00130"=>"BHM00125",
    "BHM00131"=>"JIA00015",
    "BHM00132"=>"OAS00001",
    "JIA00029"=>"BHM00117",
    "JIA00040"=>"OAS00018",
    "JIA00047"=>"OAS00034",
    "JIA00048"=>"MUS00015",
    "JIA00050"=>"NCL00017",
    "OAS00012"=>"BHM00162",
    "OAS00018"=>"JIA00016",
    "OAS00019"=>"OAS00005",
    "OAS00022"=>"BHM00118",
    "OAS00040"=>"OAS00019",
    "ORA00004"=>"OAS00035",
    "ORA00007"=>"NCL00001",
    "ORA00016"=>"OAS00023",
    "ORA00027"=>"JIA00062",
    "JIA00053"=>"OAS00013",
    "OAS00008"=>"ORA00001",
    "OAS00011"=>"BHM00127",
    "OAS00015"=>"OAS00022",
    "OAS00034"=>"ORA00013",
    "OAS00035"=>"NCL00003",
    "ORA00013"=>"OAS00037",
    "ORA00019"=>"JIA00063",
    "ORA00022"=>"JIA00001",
    "ORA00028"=>"JIA00034",
    "BHM00091"=>"BHM00130",
    "BHM00138"=>"OAS00040",
    "BHM00139"=>"ORA00019",
    "JIA00055"=>"NCL00004",
    "JIA00057"=>"OAS00049",
    "JIA00059"=>"NCL00023",
    "MUS00015"=>"JIA00026",
    "NCL00001"=>"JIA00035",
    "NCL00003"=>"BHM00131",
    "NCL00004"=>"ORA00004",
    "OAS00024"=>"ORA00022",
    "OAS00028"=>"OAS00024",
    "OAS00039"=>"OAS00052",
    "BHM00121"=>"NCL00024",
    "BHM00140"=>"JIA00027",
    "JIA00054"=>"JIA00037",
    "MUS00011"=>"BHM00132",
    "NCL00016"=>"ORA00007",
    "NCL00017"=>"ORA00028",
    "OAS00023"=>"OAS00028",
    "OAS00037"=>"OAS00053",
    "OAS00049"=>"NCL00025",
    "OAS00052"=>"OAS00014",
    "OAS00053"=>"JIA00043",
    "OAS00054"=>"JIA00029",
    "OAS00065"=>"ORA00016",
    "NCL00020"=>"BHM00091",
    "BHM00126"=>"OAS00039",
    "NCL00008"=>"OAS00054",
    "BHM00125"=>"NCL00026",
    "BHM00162"=>"JIA00031",
    "JIA00062"=>"JIA00046",
    "JIA00063"=>"JIA00040",
    "NCL00023"=>"ORA00027",
    "NCL00024"=>"BHM00138",
    "NCL00025"=>"BHM00121",
    "NCL00026"=>"OAS00065",
    "NCL00028"=>"NCL00028")