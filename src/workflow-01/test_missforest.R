require(data.table)
require(missForest)
library(doParallel)


dataset <- fread("/home/franciscoportas/buckets/b1/expw/CA-0001/dataset.csv.gz")


to_impute_variables <- c(
  "ctrx_quarter",
  "mpasivos_margen",
  "mrentabilidad_annual",
  "mactivos_margen",
  "mtransferencias_recibidas",
  "mtarjeta_visa_consumo",
  "Visa_mfinanciacion_limite",
  "chomebanking_transacciones",
  "mrentabilidad"
)

set.seed(123)

n <- 10000
sampled_rows <- dataset[sample(.N, n)]

sampled_rows <- sampled_rows[,..to_impute_variables]


# Obtener las columnas que no están en to_impute_variables
#cols_to_impute_zero <- setdiff(names(sampled_rows), to_impute_variables)


# Imputar 0 a los valores NA en las columnas que no están en to_impute_variables
# sampled_rows[, (cols_to_impute_zero) := lapply(.SD, function(x) ifelse(is.na(x), 0, x)), .SDcols = cols_to_impute_zero]

#sampled_rows[, clase_ternaria := factor(clase_ternaria)]

# PARALELIZACION
num_cores <- detectCores() - 2
# Crear un clúster de núcleos
cl <- makeCluster(num_cores)
# Registrar el clúster para usar en la función missForest
registerDoParallel(cl)


imputed_data <- missForest(sampled_rows,
                           verbose = TRUE,
                           ntree = 20,
                           parallelize = "forests"
                           )

stopCluster(cl)

rf_model <- imputed_data$ximp