library(rvest)
library(dplyr)


link = "https://www.pikm.my/member-directory/"
page = read_html(link)

name = page %>% html_nodes(".wpbdp-listing .listing-title a") %>% html_text()
page_links = page %>% html_nodes(".wpbdp-listing .listing-title a") %>% 
  html_attr("href") 


get_details = function(page_link){
  dir_page = read_html(page_link)
  dir_details = dir_page %>% html_nodes(".wpbdp-listing .listing-details") %>%
    html_text()
  return(dir_details)
}

details = sapply(page_links, FUN = get_details, USE.NAMES = FALSE)

directory = data.frame(name, details)
write.csv(directory, "directory.csv")

