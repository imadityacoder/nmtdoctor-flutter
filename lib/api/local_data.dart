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
    "cardId": "1",
    "title": "Basic Health Checkup",
    "description":
        "A starter pack designed to provide a comprehensive overview of your overall health. This package includes essential tests such as CBC, Blood Sugar Tests, and Lipid Profile.",
    "price": "999",
    "preprice": "1499",
    "svgAsset": "assets/icons/sample.svg",
    "tests": ["1", "7", "8", "22", "23", "24", "25"]
  },
  {
    "cardId": "6",
    "title": "Heart Health Package",
    "description":
        "This package includes Lipid Profile, CRP, and ECG to assess cardiovascular health.",
    "price": "1499",
    "preprice": "1999",
    "svgAsset": "assets/icons/heart.svg",
    "tests": ["22", "23", "24", "25", "29", "47"]
  },
  {
    "cardId": "3",
    "title": "Liver Function Test Package",
    "description":
        "The Liver Function Test Package evaluates liver enzymes and includes ALT, AST, and Bilirubin tests.",
    "price": "1199",
    "preprice": "1699",
    "svgAsset": "assets/icons/liver.svg",
    "tests": ["11", "12", "13", "14"]
  },
  {
    "cardId": "4",
    "title": "Kidney Function Test Package",
    "description":
        "This package evaluates kidney function through key markers such as Serum Creatinine, BUN, and Uric Acid.",
    "price": "1099",
    "preprice": "1599",
    "svgAsset": "assets/icons/kidney.svg",
    "tests": ["19", "20", "21"]
  },
  {
    "cardId": "5",
    "title": "Thyroid Profile Package",
    "description":
        "This package includes TSH, Free T3, and Free T4 to evaluate thyroid function.",
    "price": "899",
    "preprice": "1299",
    "svgAsset": "assets/icons/pills.svg",
    "tests": ["26", "27", "28"]
  },
];

List<Map<String, dynamic>> healthPacks = [
  {
    "cardId": "1",
    "title": "Basic Health Checkup",
    "description":
        "A starter pack designed to provide a comprehensive overview of your overall health. This package includes essential tests such as CBC, Blood Sugar Tests, and Lipid Profile to evaluate your heart health, blood parameters, and glucose levels. It's the ideal choice for individuals looking for a general health checkup to get a baseline understanding of their physical condition and identify early signs of potential health issues.",
    "price": "999",
    "preprice": "1499",
    "svgAsset": "assets/icons/sample.svg",
  },
  {
    "cardId": "2",
    "title": "Diabetes Care Package",
    "description":
        "This specialized package focuses on diabetes care and management. It includes key tests such as Fasting Blood Sugar (FBS), Postprandial Blood Sugar (PPBS), HbA1c, and Lipid Profile. These tests are designed to assess how well your body is managing blood sugar levels and to evaluate any potential long-term damage caused by diabetes. If you are at risk for diabetes or already diagnosed, this package helps you monitor your condition and make necessary lifestyle adjustments.",
    "price": "1299",
    "preprice": "1799",
    "svgAsset": "assets/icons/petri.svg",
  },
  {
    "cardId": "3",
    "title": "Liver Function Test Package",
    "description":
        "The Liver Function Test (LFT) Package is designed to provide an in-depth assessment of your liver's health and function. It includes tests like ALT, AST, and Bilirubin to evaluate liver enzymes, which can indicate liver damage or disease. This package is particularly beneficial for individuals with risk factors such as excessive alcohol consumption, obesity, or a family history of liver disease. Early detection can help prevent serious conditions such as cirrhosis or liver failure.",
    "price": "1199",
    "preprice": "1699",
    "svgAsset": "assets/icons/liver.svg",
  },
  {
    "cardId": "4",
    "title": "Kidney Function Test Package",
    "description":
        "This package is designed to evaluate kidney function by testing key markers such as Serum Creatinine, Blood Urea Nitrogen (BUN), and Uric Acid. These tests can help detect kidney disease in its early stages, especially for those at risk due to conditions like hypertension, diabetes, or a family history of kidney disease. Regular monitoring can help prevent kidney failure and allow for timely intervention and treatment.",
    "price": "1099",
    "preprice": "1599",
    "svgAsset": "assets/icons/kidney.svg",
  },
  {
    "cardId": "5",
    "title": "Thyroid Profile Package",
    "description":
        "The Thyroid Profile Package includes tests for TSH, Free T3, and Free T4, which are essential for evaluating thyroid function. Thyroid disorders can affect metabolism, energy levels, and overall health. If you experience symptoms such as fatigue, weight changes, or mood swings, this package will help diagnose potential thyroid conditions such as hypothyroidism or hyperthyroidism. It’s particularly beneficial for those with a family history of thyroid disorders or individuals experiencing unexplained symptoms.",
    "price": "899",
    "preprice": "1299",
    "svgAsset": "assets/icons/pills.svg",
  },
  {
    "cardId": "6",
    "title": "Heart Health Package",
    "description":
        "Designed to assess cardiovascular health, this package includes essential tests such as Lipid Profile, CRP (C-Reactive Protein), and ECG (Electrocardiogram). These tests can help detect heart disease, high cholesterol, and inflammation. If you're at risk of heart disease or have a family history of cardiovascular issues, this package is crucial in identifying potential problems early on and taking steps to protect your heart.",
    "price": "1499",
    "preprice": "1999",
    "svgAsset": "assets/icons/heart.svg",
  },
  {
    "cardId": "7",
    "title": "Women's Health Package",
    "description":
        "This package is tailored for women’s health, offering a thorough check-up that includes CBC (Complete Blood Count), Estradiol (a key hormone for women), and Thyroid Profile. These tests are designed to monitor general health, hormonal balance, and thyroid function. It’s especially beneficial for women at different life stages, including those experiencing menstrual irregularities, menopause, or preconception planning. Regular monitoring can help maintain optimal health and prevent issues before they arise.",
    "price": "1699",
    "preprice": "2199",
    "svgAsset": "assets/icons/nurse.svg",
  },
  {
    "cardId": "8",
    "title": "Men's Health Package",
    "description":
        "This package is designed to assess general health and hormonal balance in men. It includes tests such as CBC, Testosterone, and Lipid Profile, which are critical for evaluating blood health, hormone levels, and cardiovascular risk. The Men's Health Package is especially useful for men experiencing symptoms of low energy, muscle weakness, or changes in libido. It helps detect potential health issues early and promotes better health management.",
    "price": "1599",
    "preprice": "2099",
    "svgAsset": "assets/icons/doctor.svg",
  },
  {
    "cardId": "9",
    "title": "Full Body Checkup",
    "description":
        "The Full Body Checkup is a comprehensive health package that covers a wide range of tests across various health parameters. This package is designed for those who want to get a thorough evaluation of their overall health. It includes blood tests, organ function tests, and screenings for common health conditions such as high blood pressure, diabetes, and cholesterol. Ideal for individuals seeking a complete health assessment to maintain a healthy lifestyle or detect potential issues early.",
    "price": "2999",
    "preprice": "3999",
    "svgAsset": "assets/icons/kit.svg",
  },
  {
    "cardId": "10",
    "title": "Iron Deficiency Panel",
    "description":
        "The Iron Deficiency Panel is designed to assess iron levels in your body and detect potential anemia or iron-related disorders. This package includes tests such as Serum Iron, TIBC (Total Iron Binding Capacity), and Ferritin. If you’re experiencing symptoms such as fatigue, pale skin, or weakness, this package can help identify if iron deficiency or anemia is the cause. It’s especially beneficial for women, vegetarians, and individuals with a history of iron-related issues.",
    "price": "799",
    "preprice": "1199",
    "svgAsset": "assets/icons/dna.svg",
  },
];
