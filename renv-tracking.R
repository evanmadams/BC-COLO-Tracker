#renviornment tracking

library(renv)
renv::activate() #startup the process
renv::status() #determines if there is a lockfile for the project
renv::snapshot() #creates a lockfile so that we track what goes into this
