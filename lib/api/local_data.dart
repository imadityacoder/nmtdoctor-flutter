List healthChecks = [
  {"title": "Hemoglobin (Hb)", "price": "250", "preprice": "300"},
  {"title": "Red Blood Cell Count (RBC)", "price": "300", "preprice": "350"},
  {"title": "White Blood Cell Count (WBC)", "price": "270", "preprice": "320"},
  {"title": "Platelet Count", "price": "220", "preprice": "280"},
  {"title": "Hematocrit (Hct)", "price": "280", "preprice": "330"},
  {"title": "Mean Corpuscular Volume (MCV)", "price": "260", "preprice": "310"},
  {
    "title": "Mean Corpuscular Hemoglobin (MCH)",
    "price": "240",
    "preprice": "290"
  },
  {
    "title": "Mean Corpuscular Hemoglobin Concentration (MCHC)",
    "price": "260",
    "preprice": '310'
  },
  {
    "title": "Red Cell Distribution Width (RDW)",
    "price": "250",
    "preprice": '300'
  },
  {"title": "Fasting Blood Sugar (FBS)", "price": '180', "preprice": '230'},
  {
    "title": "Postprandial Blood Sugar (PPBS)",
    "price": '200',
    "preprice": "250"
  },
  {"title": "Random Blood Sugar (RBS)", "price": '150', "preprice": '200'},
  {"title": "HbA1c (Glycated Hemoglobin)", "price": '350', "preprice": '400'},
  {"title": "Alanine Transaminase (ALT)", "price": '300', "preprice": '350'},
  {"title": "Aspartate Transaminase (AST)", "price": '320', "preprice": '370'},
  {"title": "Alkaline Phosphatase (ALP)", "price": '350', "preprice": '400'},
  {
    "title": "Bilirubin (Total, Direct, Indirect)",
    "price": '280',
    "preprice": '330'
  },
  {"title": "Albumin", "price": '300', "preprice": '350'},
  {"title": "Globulin", "price": "250", "preprice": '300'},
  {"title": "Prothrombin Time (PT)", "price": '320', "preprice": '370'},
  {"title": "Blood Urea Nitrogen (BUN)", "price": '220', "preprice": '270'},
  {"title": "Serum Creatinine", "price": "250", "preprice": '300'},
  {"title": "Uric Acid", "price": '270', "preprice": '320'},
  {
    "title": "Estimated Glomerular Filtration Rate (eGFR)",
    "price": '400',
    "preprice": '450'
  },
  {"title": "Total Cholesterol", "price": '350', "preprice": '400'},
  {
    "title": "High-Density Lipoprotein (HDL)",
    "price": '300',
    "preprice": '350'
  },
  {"title": "Low-Density Lipoprotein (LDL)", "price": '320', "preprice": '370'},
  {"title": "Triglycerides (TG)", "price": '280', "preprice": '330'},
  {
    "title": "Very-Low-Density Lipoprotein (VLDL)",
    "price": "260",
    "preprice": '310'
  },
  {
    "title": "Thyroid-Stimulating Hormone (TSH)",
    "price": '350',
    "preprice": '400'
  },
  {"title": "Free T3 (Triiodothyronine)", "price": '300', "preprice": '350'},
  {"title": "Free T4 (Thyroxine)", "price": '280', "preprice": '330'},
  {"title": "Sodium (Na+)", "price": '200', "preprice": "250"},
  {"title": "Potassium (K+)", "price": '230', "preprice": '280'},
  {"title": "Chloride (Cl-)", "price": '210', "preprice": "260"},
  {"title": "Calcium (Ca2+)", "price": '240', "preprice": '290'},
  {"title": "Serum Iron", "price": '300', "preprice": '350'},
  {
    "title": "Total Iron Binding Capacity (TIBC)",
    "price": '320',
    "preprice": '370'
  },
  {"title": "Ferritin", "price": '350', "preprice": '400'},
  {"title": "Transferrin Saturation", "price": '280', "preprice": '330'},
  {"title": "Prothrombin Time (PT)", "price": "250", "preprice": '300'},
  {
    "title": "International Normalized Ratio (INR)",
    "price": '200',
    "preprice": "250"
  },
  {
    "title": "Activated Partial Thromboplastin Time (aPTT)",
    "price": '300',
    "preprice": "350"
  },
  {"title": "C-Reactive Protein (CRP)", "price": "300", "preprice": "350"},
  {
    "title": "Erythrocyte Sedimentation Rate (ESR)",
    "price": "250",
    "preprice": "300"
  },
  {"title": "Insulin", "price": "400", "preprice": "450"},
  {"title": "Cortisol", "price": "350", "preprice": "400"},
  {"title": "Testosterone", "price": "320", "preprice": "370"},
  {"title": "Estradiol", "price": "300", "preprice": "350"},
  {"title": "Progesterone", "price": "300", "preprice": "350"},
];

List<Map<String, dynamic>> popularCheckups = [
  {
    "title": "Basic Health Checkup",
    "price": "999",
    "preprice": "1499",
    "icon": "assets/icons/sample.svg",
  },
  {
    "title": "Liver Function Test Package",
    "price": "1199",
    "preprice": "1699",
    "icon": "assets/icons/liver.svg",
  },
  {
    "title": "Kidney Function Test Package",
    "price": "1099",
    "preprice": "1599",
    "icon": "assets/icons/kidney.svg",
  },
  {
    "title": "Thyroid Profile Package",
    "price": "899",
    "preprice": "1299",
    "icon": "assets/icons/pills.svg",
  },
  {
    "title": "Heart Health Package",
    "description":
        "Designed for cardiovascular health, including Lipid Profile, CRP, and ECG.",
    "price": "1499",
    "preprice": "1999",
    "icon": "assets/icons/heart.svg",
  },
];

List<Map<String, dynamic>> healthPacks = [
  {
    "title": "Basic Health Checkup",
    "description":
        "A starter pack to assess overall health, including CBC, Blood Sugar Tests, and Lipid Profile.",
    "price": "999",
    "preprice": "1499",
    "svgAsset": "assets/icons/sample.svg",
    "testsIncluded": ["CBC", "Blood Sugar Tests", "Lipid Profile"],
    "recommendedFor": "General health assessment."
  },
  {
    "title": "Diabetes Care Package",
    "description":
        "Monitor and manage diabetes with FBS, PPBS, HbA1c, and Lipid Profile.",
    "price": "1299",
    "preprice": "1799",
    "svgAsset": "assets/icons/petri.svg",
    "testsIncluded": ["FBS", "PPBS", "HbA1c", "Lipid Profile"],
    "recommendedFor": "Diabetes management."
  },
  {
    "title": "Liver Function Test Package",
    "description": "Evaluate liver health with ALT, AST, Bilirubin, and more.",
    "price": "1199",
    "preprice": "1699",
    "svgAsset": "assets/icons/liver.svg",
    "testsIncluded": ["ALT", "AST", "Bilirubin"],
    "recommendedFor": "Liver health assessment."
  },
  {
    "title": "Kidney Function Test Package",
    "description":
        "Focused on kidney health with Serum Creatinine, BUN, and Uric Acid.",
    "price": "1099",
    "preprice": "1599",
    "svgAsset": "assets/icons/kidney.svg",
    "testsIncluded": ["Serum Creatinine", "BUN", "Uric Acid"],
    "recommendedFor": "Kidney health assessment."
  },
  {
    "title": "Thyroid Profile Package",
    "description":
        "Includes TSH, Free T3, and Free T4 to assess thyroid gland function.",
    "price": "899",
    "preprice": "1299",
    "svgAsset": "assets/icons/pills.svg",
    "testsIncluded": ["TSH", "Free T3", "Free T4"],
    "recommendedFor": "Thyroid health evaluation."
  },
  {
    "title": "Heart Health Package",
    "description":
        "Designed for cardiovascular health, including Lipid Profile, CRP, and ECG.",
    "price": "1499",
    "preprice": "1999",
    "svgAsset": "assets/icons/heart.svg",
    "testsIncluded": ["Lipid Profile", "CRP", "ECG"],
    "recommendedFor": "Cardiovascular health."
  },
  {
    "title": "Women's Health Package",
    "description":
        "Covers hormonal and general health for women, including CBC, Estradiol, and Thyroid Profile.",
    "price": "1699",
    "preprice": "2199",
    "svgAsset": "assets/icons/nurse.svg",
    "testsIncluded": ["CBC", "Estradiol", "Thyroid Profile"],
    "recommendedFor": "Women’s general and hormonal health."
  },
  {
    "title": "Men's Health Package",
    "description":
        "Includes tests for men’s health, such as CBC, Testosterone, and Lipid Profile.",
    "price": "1599",
    "preprice": "2099",
    "svgAsset": "assets/icons/doctor.svg",
    "testsIncluded": ["CBC", "Testosterone", "Lipid Profile"],
    "recommendedFor": "Men’s general health."
  },
  {
    "title": "Full Body Checkup",
    "description":
        "A comprehensive package covering all major health parameters.",
    "price": "2999",
    "preprice": "3999",
    "svgAsset": "assets/icons/kit.svg",
    "testsIncluded": ["Complete Health Tests"],
    "recommendedFor": "Comprehensive health assessment."
  },
  {
    "title": "Iron Deficiency Panel",
    "description":
        "Checks for anemia and iron-related disorders, including Serum Iron, TIBC, and Ferritin.",
    "price": "799",
    "preprice": "1199",
    "svgAsset": "assets/icons/dna.svg",
    "testsIncluded": ["Serum Iron", "TIBC", "Ferritin"],
    "recommendedFor": "Iron deficiency and anemia detection."
  },
];
