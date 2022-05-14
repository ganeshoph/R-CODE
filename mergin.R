##R code to merge vision center data 
##All exort data from VC are stored in some folder. If they are in "XLSX" format fine, else uncoment "paste(vidy[i],"x",sep = "")"
##14May 2022
library(readxl)
library(writexl)
vid<-choose.dir()
vidy<-list.files(vid, pattern = ".xls",full.names = T,recursive = TRUE)
demo.gaba<-as.data.frame(matrix(nrow = 1,ncol = 159))
names(demo.gaba)<-c("MRNo.", "Date First Seen", "Unique ID", "Patient Name", "Category", "Mobile", "phone", "Age", "Gender", "EducationID", "Education", "Other_Education", "OccupationID", "Occupation", "Other_Occupation", "Address", "Secondary Center", "Vision Center", "Referal from", "Review", "Chief Complaints", "History of Present Illness", "History of Past Illness", "Family History", "Surgeries / Lasers", "Allergies", "Current Treatment", "Personal History", "Nutritional Status", "General Examination", "Systemic Examination", "Unaided OD Distance", "Unaided OD Near", "Unaided OS Distance", "Unaided OS Near", "Aided(Glasses) OD Distance", "Aided(Glasses) OD Near", "Aided(Glasses) OS Distance", "Aided(Glasses) OS Near", "Pin Hole OD", "Pin Hole OS", "Near Vision OD", "Near Vision OS", "Near Vision OD (N)", "Near Vision OD (RS)", "Near Vision OD Cms", "Near Vision Language", "Near Vision OS (N)", "Near Vision OS (RS)", "Near Vision OS Cms", "Near Vision OS Language", "Retinoscopy OD Vertical", "Retinoscopy OD Angle...53", "Retinoscopy OD list", "Retinoscopy OS Vertical", "Retinoscopy OS Angle...56", "Retinoscopy OS list", "Retinoscopy OD Horizontal", "Retinoscopy OD Angle...59", "Retinoscopy OS Horizontal", "Retinoscopy OS Angle...61", "Retinoscopy OD Sph", "Retinoscopy OD Cyl", "Retinoscopy OD Axis", "Retinoscopy OD Remarks", "Retinoscopy OS Sph", "Retinoscopy OS Cyl", "Retinoscopy OS Axis", "Retinoscopy OS Remarks", "PGP OD Sph", "PGP OD Cyl", "PGP OD Axis", "PGP OD Add", "PGP OD Remarks", "PGP Type of lens", "PGP OS Sph", "PGP OS Cyl", "PGP OS Axis", "PGP OS Add", "PGP OS Remarks", "FSR OD Sph", "FSR OD Cyl", "FSR OD Axis", "FSR OD BCVA", "FSR OD Add Near Vision", "FSR OS Sph", "FSR OS Cyl", "FSR OS Axis", "FSR OS BCVA", "FSR OS Add Near Vision", "FSR Remarks", "Lens Material", "Mode of wear", "Lens Type", "Frame Material", "Lens Tint", "Speciality Lens", "Lens Surface Coating", "Special Instruction", "Remarks", "Facial Symmetry", "External Face", "Head Posture", "Ocular Motility OD", "Ocular Motility OS", "Ocular Position OD", "Ocular Position OS", "Eyelids OD", "Eyelids OS", "Conjunctiva OD", "Conjunctiva OS", "Sclera OD", "Sclera OS", "Cornea OD", "Cornea OS", "Anterior Chamber OD", "Anterior Chamber OS", "Iris OD", "Iris OS", "Pupil OD", "Pupil OS", "Pupil Size OD (mm)", "Pupil Size OS (mm)", "Lens OD", "Lens OS", "Anterior Vitreous OD", "Anterior Vitreous OS", "IOP OD", "IOP OS", "IOP mm of HG at", "IOP OD Medication", "IOP OS Medication", "Media OD", "Media OS", "PVD OD", "PVD OS", "Optic Disc OD", "Optic Disc OS", "Optic Disc Size OD", "Optic Disc Size OS", "Cup/Disc Ratio OD", "Cup/Disc Ratio OS", "Blood Vessels Arteries OD", "Blood Vessels Arteries OS", "Blood Vessels Veins OD", "Blood Vessels Veins OS", "Blood Vessels Macula OD", "Blood Vessels Macula OS", "Blood Vessels Fundus OD", "Blood Vessels Fundus OS", "Blood Vessels Remakrs", "Ocular Diagnosis", "Sysetmic Diagnosis", "Referral Advice", "Glasses Advice", "Next Review", "System Name", "System Code", "Test Metrics")
for (i in seq_along(vidy)) {
  # If files are xls then use this to read files
  #paste(vidy[i],"x",sep = "")
  vidya<-NULL
  vidya<-suppressMessages(read_xlsx(vidy[i],sheet = "Patient Details"))
  demo.gaba<-rbind(demo.gaba,vidya)
}
demo.gaba<-demo.gaba[-1,]
File.name<-paste(Sys.getenv("USERPROFILE"),"\\Desktop","\\VISIONCENTER.xlsx",sep = "")
write_xlsx(demo.gaba,File.name)
