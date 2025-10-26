library(QtAC)
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.8.0_361")
work_folder  <- "C:/Users/joc_h/lightcdmx/QtAC"
observ_data  <- "C:/Users/joc_h/lightcdmx/QtAC/Prueba.txt"
infodyn_path <- "C:/Users/joc_h/Documents/R/QtAC/dist/MTinfodynamics.jar"

num_timepoints <- 20
signfac <- 0.1


# load the data
Data <- QtAC.TXT.reader(observ_data, col_names = FALSE, row_names = TRUE)

# compute networks of information transfer for every time point starting from num_timepoints
result_mtx <- QtAC(Data, num_timepoints, infodyn_path, l = 10L, k = 10L, delay = 2L)

# take only information transfers passing the significance level into account
result_mtx_sig <- QtAC.signfactor(result_mtx, signfac)

# calculate the three systemic variables for every network
maturation <- QtAC.maturation(result_mtx_sig)

# plot the first network of information transfers (corresponding to time point 30) and save it
QtAC.network(result_mtx_sig, num_mtx = 1, edge_label = TRUE, arrow_width = 2, layout = "nicely", save = TRUE)

# plot the development of potential, connectedness, and resilience over time and save it
QtAC.2dplot(maturation, save = TRUE)

# plot the development of potential and connectedness w.r.t. each other and save it
QtAC.2dmixplot(maturation, "potential", "connectedness", save = TRUE)

# plot a 3D plot of potential, connectedness, and resilience
QtAC.3dplot(maturation, mat_points = TRUE)