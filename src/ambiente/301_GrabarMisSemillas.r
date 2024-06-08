# Este script almacena definitivamente sus cinco semillas
# en el bucket, de forma que NO deba cargarlas en cada script

require( "data.table" )

# reemplazar aqui por SUS semillas 
mis_semillas <- c(106549, 177019, 239993, 308879, 429449, 507631, 576799, 645841, 711661, 799421, 856421, 904987, 408899, 507887, 673283, 722467, 874961, 923699, 553093, 655373)

tabla_semillas <- as.data.table(list( semilla = mis_semillas ))

fwrite( tabla_semillas,
    file = "~/buckets/b1/datasets/mis_semillas.txt",
    sep = "\t"
)
