url <- "https://docs.google.com/spreadsheets/d/1xbR7R0VDsJRSFsaCl_a1nKnIW3qfRwyY9F8K8kez2g4/edit?usp=sharing"
pt_1 <- read_sheet(ss = url,
                   sheet = "Part 1")
pt_2 <- read_sheet(ss = url,
                   sheet = "Part 2")

pt_2m <- pt_2 %>%
  filter(Stain_Type == "Myosin") %>%
  rename(M_Mean	 = Mean,
         M_Min	= Min,
         M_Max	= Max,
         M_Int_Den	= Integrated_Density,
         M_Raw_Int_Den = Raw_Integrated_Density) %>%
  select(-Stain_Type, -Image_Set)

pt_2a <- pt_2 %>%
  filter(Stain_Type == "Actin") %>%
  rename(A_Mean	 = Mean,
         A_Min	= Min,
         A_Max	= Max,
         A_Int_Den	= Integrated_Density,
         A_Raw_Int_Den = Raw_Integrated_Density) %>%
  select(-Stain_Type, -Image_Set)

pt_2_tidy <- left_join(pt_2m, pt_2a) %>%
  mutate(M_A_Ratio = M_Mean/A_Mean) %>%
  select(-ROI)
write_csv(pt_2_tidy, "/home/kaijli/biol372/Final_Report/Pt2Tidy.csv")
