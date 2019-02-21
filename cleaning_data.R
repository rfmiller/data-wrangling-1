library(dplyr)
library(tidyr)

refine_original <- read.csv("refine_original.csv")

refine_original$company <- tolower(refine_original$company)

refine_original$company <- sub(".*\\ps$", "philips", refine_original$company)
refine_original$company <- sub("^ak.*", "akzo", refine_original$company)
refine_original$company <- sub("^u.*", "unilever", refine_original$company)
refine_original$company <- sub("^v.*", "van houten", refine_original$company)

refine_original <- separate (refine_original, "Product.code...number", c("product_code", "product_number"), sep = "-")

refine_original$product_category <- sub("^p$", "Smartphone", sub("^x$", "Laptop", sub("^v$", "TV", sub("^q$", "Tablet", refine_original$product_code))))

refine_original <- mutate(refine_original, full_address = paste(address, city, country, sep = ", "))

refine_original <- mutate(refine_original, company_philips = ifelse(company == "philips", 1, 0))
refine_original <- mutate(refine_original, company_akzo = ifelse(company == "akzo", 1, 0))
refine_original <- mutate(refine_original, company_van_houten = ifelse(company == "van houten", 1, 0))
refine_original <- mutate(refine_original, company_unilever = ifelse(company == "unilever", 1, 0))
refine_original <- mutate(refine_original, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
refine_original <- mutate(refine_original, product_tv = ifelse(product_category == "TV", 1, 0))
refine_original <- mutate(refine_original, product_laptop = ifelse(product_category == "Laptop", 1, 0))
refine_original <- mutate(refine_original, product_tablet = ifelse(product_category == "Tablet", 1, 0))

write.csv(refine_original, "refine_clean.csv")