import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  final List<Map<String, dynamic>> supplements = [
    {
      "name": "Omega-3 Fish Oil",
      "benefits": "Supports heart health, reduces inflammation, improves mental health",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "1000 mg per day",
      "detail": "Omega-3 Fish Oil is rich in EPA and DHA, essential fatty acids that support overall health.",
      "image_url": "https://example.com/images/omega3.jpg",
      "rating": 4.5,
      "diseases": "Heart disease, depression, arthritis"
    },
    {
      "name": "Vitamin D",
      "benefits": "Supports bone health, boosts immune system, improves mood",
      "interaction_warning": "Can interact with steroids and weight loss drugs",
      "dosage": "600-800 IU per day",
      "detail": "Vitamin D is essential for calcium absorption and maintaining healthy bones.",
      "image_url": "https://example.com/images/vitamin_d.jpg",
      "rating": 4.7,
      "diseases": "Osteoporosis, seasonal affective disorder, immune deficiencies"
    },
    {
      "name": "Probiotics",
      "benefits": "Supports gut health, improves digestion, boosts immune system",
      "interaction_warning": "Can interact with immunosuppressant drugs",
      "dosage": "1-10 billion CFUs per day",
      "detail": "Probiotics are live bacteria that provide numerous health benefits when consumed.",
      "image_url": "https://example.com/images/probiotics.jpg",
      "rating": 4.6,
      "diseases": "Irritable bowel syndrome (IBS), diarrhea, infections"
    },
    {
      "name": "Turmeric",
      "benefits": "Reduces inflammation, supports joint health, improves brain function",
      "interaction_warning": "Can interact with blood-thinning medications and diabetes drugs",
      "dosage": "500-2000 mg per day",
      "detail": "Turmeric contains curcumin, a powerful anti-inflammatory and antioxidant compound.",
      "image_url": "https://example.com/images/turmeric.jpg",
      "rating": 4.8,
      "diseases": "Arthritis, Alzheimer's disease, heart disease"
    },
    {
      "name": "Magnesium",
      "benefits": "Supports muscle and nerve function, maintains healthy bones, reduces migraine frequency",
      "interaction_warning": "Can interact with certain antibiotics and diuretics",
      "dosage": "310-420 mg per day",
      "detail": "Magnesium is a mineral essential for many bodily functions, including muscle and nerve function.",
      "image_url": "https://example.com/images/magnesium.jpg",
      "rating": 4.4,
      "diseases": "Migraine, osteoporosis, muscle cramps"
    },
    {
      "name": "Vitamin C",
      "benefits": "Boosts immune system, promotes healthy skin, aids in wound healing",
      "interaction_warning": "High doses can cause gastrointestinal discomfort",
      "dosage": "75-90 mg per day",
      "detail": "Vitamin C is an essential nutrient that supports immune function and skin health.",
      "image_url": "https://example.com/images/vitamin_c.jpg",
      "rating": 4.9,
      "diseases": "Common cold, scurvy, skin aging"
    },
    {
      "name": "Zinc",
      "benefits": "Supports immune function, promotes wound healing, improves sense of taste and smell",
      "interaction_warning": "Can interact with antibiotics and diuretics",
      "dosage": "8-11 mg per day",
      "detail": "Zinc is a mineral essential for immune function and cellular metabolism.",
      "image_url": "https://example.com/images/zinc.jpg",
      "rating": 4.7,
      "diseases": "Common cold, zinc deficiency, skin ulcers"
    },
    {
      "name": "Calcium",
      "benefits": "Supports bone health, aids in muscle function, helps with nerve transmission",
      "interaction_warning": "Can interact with certain medications like bisphosphonates",
      "dosage": "1000-1200 mg per day",
      "detail": "Calcium is essential for maintaining strong bones and teeth.",
      "image_url": "https://example.com/images/calcium.jpg",
      "rating": 4.6,
      "diseases": "Osteoporosis, hypocalcemia, muscle cramps"
    },
    {
      "name": "Iron",
      "benefits": "Supports red blood cell production, prevents anemia, boosts energy levels",
      "interaction_warning": "Can interact with certain antibiotics and thyroid medications",
      "dosage": "8-18 mg per day",
      "detail": "Iron is a mineral crucial for producing hemoglobin and preventing anemia.",
      "image_url": "https://example.com/images/iron.jpg",
      "rating": 4.5,
      "diseases": "Anemia, iron deficiency, fatigue"
    },
    {
      "name": "Coenzyme Q10",
      "benefits": "Supports heart health, boosts energy levels, acts as an antioxidant",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "100-200 mg per day",
      "detail": "Coenzyme Q10 is an antioxidant that supports heart health and energy production.",
      "image_url": "https://example.com/images/coq10.jpg",
      "rating": 4.8,
      "diseases": "Heart disease, high blood pressure, migraine"
    },
    {
      "name": "Folic Acid",
      "benefits": "Supports cell growth, prevents birth defects, aids in red blood cell formation",
      "interaction_warning": "Can interact with certain epilepsy medications",
      "dosage": "400-800 mcg per day",
      "detail": "Folic acid is a B vitamin important for cell growth and metabolism.",
      "image_url": "https://example.com/images/folic_acid.jpg",
      "rating": 4.7,
      "diseases": "Anemia, neural tube defects, heart disease"
    },
    {
      "name": "Vitamin B12",
      "benefits": "Supports nerve health, aids in red blood cell production, boosts energy levels",
      "interaction_warning": "Can interact with certain antibiotics and anti-seizure medications",
      "dosage": "2.4 mcg per day",
      "detail": "Vitamin B12 is essential for nerve function and the production of red blood cells.",
      "image_url": "https://example.com/images/vitamin_b12.jpg",
      "rating": 4.9,
      "diseases": "Anemia, nerve damage, fatigue"
    },
    {
      "name": "Echinacea",
      "benefits": "Boosts immune system, reduces symptoms of cold and flu, supports respiratory health",
      "interaction_warning": "Can interact with immunosuppressant drugs",
      "dosage": "300-500 mg per day",
      "detail": "Echinacea is a herb commonly used to boost the immune system and fight infections.",
      "image_url": "https://example.com/images/echinacea.jpg",
      "rating": 4.6,
      "diseases": "Common cold, respiratory infections, immune deficiencies"
    },
    {
      "name": "Ginkgo Biloba",
      "benefits": "Improves cognitive function, supports memory, boosts circulation",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "120-240 mg per day",
      "detail": "Ginkgo Biloba is an herbal supplement that supports cognitive function and circulation.",
      "image_url": "https://example.com/images/ginkgo_biloba.jpg",
      "rating": 4.7,
      "diseases": "Alzheimer's disease, dementia, poor circulation"
    },
    {
      "name": "Melatonin",
      "benefits": "Improves sleep quality, regulates sleep-wake cycle, reduces jet lag",
      "interaction_warning": "Can interact with blood-thinning medications and diabetes drugs",
      "dosage": "1-5 mg per day",
      "detail": "Melatonin is a hormone that regulates sleep-wake cycles and improves sleep quality.",
      "image_url": "https://example.com/images/melatonin.jpg",
      "rating": 4.8,
      "diseases": "Insomnia, jet lag, sleep disorders"
    },
    {
      "name": "Garlic",
      "benefits": "Supports heart health, boosts immune system, reduces blood pressure",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "600-1200 mg per day",
      "detail": "Garlic is known for its cardiovascular benefits and immune-boosting properties.",
      "image_url": "https://example.com/images/garlic.jpg",
      "rating": 4.5,
      "diseases": "Heart disease, high blood pressure, common cold"
    },
    {
      "name": "Green Tea Extract",
      "benefits": "Boosts metabolism, supports weight loss, acts as an antioxidant",
      "interaction_warning": "Can interact with blood-thinning medications and stimulants",
      "dosage": "250-500 mg per day",
      "detail": "Green Tea Extract is rich in antioxidants and supports metabolism and weight loss.",
      "image_url": "https://example.com/images/green_tea_extract.jpg",
      "rating": 4.7,
      "diseases": "Obesity, heart disease, metabolic syndrome"
    },
    {
      "name": "Collagen",
      "benefits": "Supports skin health, strengthens hair and nails, aids in joint health",
      "interaction_warning": "No significant interactions",
      "dosage": "2.5-15 grams per day",
      "detail": "Collagen is a protein that supports skin elasticity, joint health, and hair strength.",
      "image_url": "https://example.com/images/collagen.jpg",
      "rating": 4.8,
      "diseases": "Osteoarthritis, skin aging, brittle nails"
    },
    {
      "name": "Biotin",
      "benefits": "Supports hair, skin, and nail health, aids in metabolism",
      "interaction_warning": "No significant interactions",
      "dosage": "30 mcg per day",
      "detail": "Biotin is a B vitamin important for the health of hair, skin, and nails.",
      "image_url": "https://example.com/images/biotin.jpg",
      "rating": 4.9,
      "diseases": "Biotin deficiency, hair loss, brittle nails"
    },
    {
      "name": "Ashwagandha",
      "benefits": "Reduces stress and anxiety, boosts energy levels, supports cognitive function",
      "interaction_warning": "Can interact with sedatives and thyroid medications",
      "dosage": "300-500 mg per day",
      "detail": "Ashwagandha is an adaptogenic herb that helps the body manage stress and improve energy.",
      "image_url": "https://example.com/images/ashwagandha.jpg",
      "rating": 4.8,
      "diseases": "Stress, anxiety, fatigue"
    },
    {
      "name": "Resveratrol",
      "benefits": "Acts as an antioxidant, supports heart health, boosts cognitive function",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "150-500 mg per day",
      "detail": "Resveratrol is a compound found in red wine that acts as an antioxidant and supports heart health.",
      "image_url": "https://example.com/images/resveratrol.jpg",
      "rating": 4.7,
      "diseases": "Heart disease, Alzheimer's disease, inflammation"
    },
    {
      "name": "Vitamin E",
      "benefits": "Acts as an antioxidant, supports skin health, boosts immune function",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "15 mg per day",
      "detail": "Vitamin E is an antioxidant that supports immune function and skin health.",
      "image_url": "https://example.com/images/vitamin_e.jpg",
      "rating": 4.6,
      "diseases": "Skin aging, immune deficiencies, heart disease"
    },
    {
      "name": "Selenium",
      "benefits": "Acts as an antioxidant, supports thyroid function, boosts immune system",
      "interaction_warning": "Can interact with certain medications like anticoagulants",
      "dosage": "55 mcg per day",
      "detail": "Selenium is a mineral that acts as an antioxidant and supports thyroid function.",
      "image_url": "https://example.com/images/selenium.jpg",
      "rating": 4.7,
      "diseases": "Thyroid disorders, selenium deficiency, oxidative stress"
    },
    {
      "name": "Curcumin",
      "benefits": "Reduces inflammation, supports joint health, boosts brain function",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "500-2000 mg per day",
      "detail": "Curcumin is the active compound in turmeric that has powerful anti-inflammatory effects.",
      "image_url": "https://example.com/images/curcumin.jpg",
      "rating": 4.8,
      "diseases": "Arthritis, Alzheimer's disease, heart disease"
    },
    {
      "name": "Spirulina",
      "benefits": "Supports immune function, boosts energy, acts as an antioxidant",
      "interaction_warning": "Can interact with immunosuppressant drugs",
      "dosage": "1-3 grams per day",
      "detail": "Spirulina is a blue-green algae rich in nutrients and antioxidants.",
      "image_url": "https://example.com/images/spirulina.jpg",
      "rating": 4.5,
      "diseases": "Anemia, fatigue, immune deficiencies"
    },
    {
      "name": "Chlorella",
      "benefits": "Supports detoxification, boosts immune function, acts as an antioxidant",
      "interaction_warning": "Can interact with immunosuppressant drugs",
      "dosage": "1-3 grams per day",
      "detail": "Chlorella is a type of green algae that supports detoxification and immune function.",
      "image_url": "https://example.com/images/chlorella.jpg",
      "rating": 4.6,
      "diseases": "Detoxification, immune deficiencies, oxidative stress"
    },
    {
      "name": "Ginger",
      "benefits": "Reduces nausea, supports digestion, acts as an anti-inflammatory",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "1-2 grams per day",
      "detail": "Ginger is a root that supports digestion and reduces inflammation.",
      "image_url": "https://example.com/images/ginger.jpg",
      "rating": 4.7,
      "diseases": "Nausea, indigestion, inflammation"
    },
    {
      "name": "Milk Thistle",
      "benefits": "Supports liver health, acts as an antioxidant, reduces inflammation",
      "interaction_warning": "Can interact with certain medications like anticoagulants",
      "dosage": "200-400 mg per day",
      "detail": "Milk Thistle is an herb that supports liver health and acts as an antioxidant.",
      "image_url": "https://example.com/images/milk_thistle.jpg",
      "rating": 4.6,
      "diseases": "Liver disease, detoxification, inflammation"
    },
    {
      "name": "Saw Palmetto",
      "benefits": "Supports prostate health, reduces urinary symptoms, acts as an anti-inflammatory",
      "interaction_warning": "Can interact with hormone-related medications",
      "dosage": "160-320 mg per day",
      "detail": "Saw Palmetto is an herb that supports prostate health and reduces urinary symptoms.",
      "image_url": "https://example.com/images/saw_palmetto.jpg",
      "rating": 4.7,
      "diseases": "Benign prostatic hyperplasia (BPH), urinary issues, inflammation"
    },
    {
      "name": "Aloe Vera",
      "benefits": "Supports skin health, aids in digestion, acts as an anti-inflammatory",
      "interaction_warning": "Can interact with laxatives",
      "dosage": "50-200 mg per day",
      "detail": "Aloe Vera is a plant that supports skin health and aids in digestion.",
      "image_url": "https://example.com/images/aloe_vera.jpg",
      "rating": 4.8,
      "diseases": "Skin conditions, digestive issues, inflammation"
    },
    {
      "name": "Glucosamine",
      "benefits": "Supports joint health, reduces symptoms of osteoarthritis, promotes cartilage repair",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "1500 mg per day",
      "detail": "Glucosamine is a compound that supports joint health and reduces symptoms of osteoarthritis.",
      "image_url": "https://example.com/images/glucosamine.jpg",
      "rating": 4.7,
      "diseases": "Osteoarthritis, joint pain, cartilage damage"
    },
    {
      "name": "Chondroitin",
      "benefits": "Supports joint health, reduces symptoms of osteoarthritis, promotes cartilage repair",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "800-1200 mg per day",
      "detail": "Chondroitin is a compound that supports joint health and reduces symptoms of osteoarthritis.",
      "image_url": "https://example.com/images/chondroitin.jpg",
      "rating": 4.7,
      "diseases": "Osteoarthritis, joint pain, cartilage damage"
    },
    {
      "name": "Quercetin",
      "benefits": "Acts as an antioxidant, supports immune function, reduces inflammation",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "500-1000 mg per day",
      "detail": "Quercetin is a flavonoid that acts as an antioxidant and supports immune function.",
      "image_url": "https://example.com/images/quercetin.jpg",
      "rating": 4.6,
      "diseases": "Allergies, inflammation, immune deficiencies"
    },
    {
      "name": "Lutein",
      "benefits": "Supports eye health, reduces risk of macular degeneration, acts as an antioxidant",
      "interaction_warning": "No significant interactions",
      "dosage": "10-20 mg per day",
      "detail": "Lutein is a carotenoid that supports eye health and reduces the risk of macular degeneration.",
      "image_url": "https://example.com/images/lutein.jpg",
      "rating": 4.8,
      "diseases": "Macular degeneration, cataracts, eye strain"
    },
    {
      "name": "L-arginine",
      "benefits": "Supports heart health, improves circulation, boosts exercise performance",
      "interaction_warning": "Can interact with blood pressure medications",
      "dosage": "2-6 grams per day",
      "detail": "L-arginine is an amino acid that supports heart health and improves circulation.",
      "image_url": "https://example.com/images/l-arginine.jpg",
      "rating": 4.6,
      "diseases": "Heart disease, high blood pressure, erectile dysfunction"
    },
    {
      "name": "L-theanine",
      "benefits": "Promotes relaxation, improves sleep quality, reduces stress and anxiety",
      "interaction_warning": "Can interact with sedatives",
      "dosage": "100-200 mg per day",
      "detail": "L-theanine is an amino acid that promotes relaxation and improves sleep quality.",
      "image_url": "https://example.com/images/l-theanine.jpg",
      "rating": 4.7,
      "diseases": "Stress, anxiety, insomnia"
    },
    {
      "name": "Rhodiola Rosea",
      "benefits": "Reduces stress and fatigue, boosts energy levels, improves cognitive function",
      "interaction_warning": "Can interact with stimulants",
      "dosage": "200-600 mg per day",
      "detail": "Rhodiola Rosea is an adaptogenic herb that helps reduce stress and fatigue.",
      "image_url": "https://example.com/images/rhodiola_rosea.jpg",
      "rating": 4.8,
      "diseases": "Stress, fatigue, depression"
    },
    {
      "name": "Maca Root",
      "benefits": "Boosts energy levels, supports sexual health, improves mood",
      "interaction_warning": "Can interact with hormone-related medications",
      "dosage": "1.5-3 grams per day",
      "detail": "Maca Root is a plant that boosts energy levels and supports sexual health.",
      "image_url": "https://example.com/images/maca_root.jpg",
      "rating": 4.7,
      "diseases": "Fatigue, sexual dysfunction, mood disorders"
    },
    {
      "name": "Alpha Lipoic Acid",
      "benefits": "Acts as an antioxidant, supports nerve health, improves blood sugar control",
      "interaction_warning": "Can interact with diabetes medications",
      "dosage": "300-600 mg per day",
      "detail": "Alpha Lipoic Acid is an antioxidant that supports nerve health and blood sugar control.",
      "image_url": "https://example.com/images/alpha_lipoic_acid.jpg",
      "rating": 4.6,
      "diseases": "Diabetes, nerve pain, oxidative stress"
    },
    {
      "name": "N-Acetylcysteine (NAC)",
      "benefits": "Acts as an antioxidant, supports liver health, improves respiratory function",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "600-1800 mg per day",
      "detail": "N-Acetylcysteine is a compound that acts as an antioxidant and supports liver and respiratory health.",
      "image_url": "https://example.com/images/nac.jpg",
      "rating": 4.7,
      "diseases": "Chronic obstructive pulmonary disease (COPD), liver disease, oxidative stress"
    },
    {
      "name": "Beta-Alanine",
      "benefits": "Improves exercise performance, reduces muscle fatigue, boosts endurance",
      "interaction_warning": "Can cause tingling sensation (paresthesia)",
      "dosage": "2-5 grams per day",
      "detail": "Beta-Alanine is an amino acid that improves exercise performance and reduces muscle fatigue.",
      "image_url": "https://example.com/images/beta-alanine.jpg",
      "rating": 4.8,
      "diseases": "Muscle fatigue, athletic performance, exercise recovery"
    },
    {
      "name": "Hyaluronic Acid",
      "benefits": "Supports skin hydration, reduces joint pain, promotes wound healing",
      "interaction_warning": "No significant interactions",
      "dosage": "50-200 mg per day",
      "detail": "Hyaluronic Acid is a substance that supports skin hydration and reduces joint pain.",
      "image_url": "https://example.com/images/hyaluronic_acid.jpg",
      "rating": 4.9,
      "diseases": "Osteoarthritis, skin aging, dry skin"
    },
    {
      "name": "L-Carnitine",
      "benefits": "Supports fat metabolism, boosts energy levels, improves exercise performance",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "500-2000 mg per day",
      "detail": "L-Carnitine is an amino acid that supports fat metabolism and boosts energy levels.",
      "image_url": "https://example.com/images/l-carnitine.jpg",
      "rating": 4.7,
      "diseases": "Obesity, fatigue, exercise performance"
    },
    {
      "name": "GABA",
      "benefits": "Promotes relaxation, reduces anxiety, improves sleep quality",
      "interaction_warning": "Can interact with sedatives",
      "dosage": "250-750 mg per day",
      "detail": "GABA is a neurotransmitter that promotes relaxation and reduces anxiety.",
      "image_url": "https://example.com/images/gaba.jpg",
      "rating": 4.8,
      "diseases": "Anxiety, insomnia, stress"
    },
    {
      "name": "Kava",
      "benefits": "Reduces anxiety, promotes relaxation, improves sleep quality",
      "interaction_warning": "Can interact with sedatives and alcohol",
      "dosage": "100-250 mg per day",
      "detail": "Kava is an herb that reduces anxiety and promotes relaxation.",
      "image_url": "https://example.com/images/kava.jpg",
      "rating": 4.6,
      "diseases": "Anxiety, insomnia, stress"
    },
    {
      "name": "Ginseng",
      "benefits": "Boosts energy levels, supports cognitive function, reduces stress",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "200-400 mg per day",
      "detail": "Ginseng is an adaptogenic herb that boosts energy levels and supports cognitive function.",
      "image_url": "https://example.com/images/ginseng.jpg",
      "rating": 4.7,
      "diseases": "Fatigue, cognitive decline, stress"
    },
    {
      "name": "DHEA",
      "benefits": "Supports hormone balance, boosts energy levels, improves mood",
      "interaction_warning": "Can interact with hormone-related medications",
      "dosage": "25-50 mg per day",
      "detail": "DHEA is a hormone precursor that supports hormone balance and boosts energy levels.",
      "image_url": "https://example.com/images/dhea.jpg",
      "rating": 4.8,
      "diseases": "Adrenal insufficiency, aging, fatigue"
    },
    {
      "name": "Vitamin K2",
      "benefits": "Supports bone health, aids in calcium metabolism, reduces risk of heart disease",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "90-120 mcg per day",
      "detail": "Vitamin K2 is essential for bone health and calcium metabolism.",
      "image_url": "https://example.com/images/vitamin_k2.jpg",
      "rating": 4.9,
      "diseases": "Osteoporosis, heart disease, calcium deficiency"
    },
    {
      "name": "Astaxanthin",
      "benefits": "Acts as an antioxidant, supports skin health, reduces inflammation",
      "interaction_warning": "Can interact with blood-thinning medications",
      "dosage": "4-12 mg per day",
      "detail": "Astaxanthin is a carotenoid that acts as an antioxidant and supports skin health.",
      "image_url": "https://example.com/images/astaxanthin.jpg",
      "rating": 4.7,
      "diseases": "Inflammation, skin aging, oxidative stress"
    },
    {
      "name": "Psyllium Husk",
      "benefits": "Supports digestive health, aids in weight management, reduces cholesterol levels",
      "interaction_warning": "Can interact with diabetes medications",
      "dosage": "5-10 grams per day",
      "detail": "Psyllium Husk is a fiber supplement that supports digestive health and weight management.",
      "image_url": "https://example.com/images/psyllium_husk.jpg",
      "rating": 4.8,
      "diseases": "Constipation, high cholesterol, irritable bowel syndrome (IBS)"
    }
  ];


  void uploadData(context) async {
    final CollectionReference supplementsCollection = FirebaseFirestore.instance.collection('supplements');

    for (var supplement in supplements) {
      await supplementsCollection.add(supplement);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Supplements uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Supplements'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadData(context);

          },
          child: Text('Upload Data'),
        ),
      ),
    );
  }
}
