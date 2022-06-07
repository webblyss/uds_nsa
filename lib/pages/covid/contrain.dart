class Constrain {
  String test1;

  Constrain({
    this.test1,
  });
  static List<Constrain> getField() {
    return <Constrain>[
      Constrain(
        test1:
            "Some people infected with the virus have no symptoms. When the virus does cause symptoms, common ones include fever, body ache, dry cough, fatigue, chills, headache, sore throat, loss of appetite, and loss of smell. In some people, COVID-19 causes more severe symptoms like high fever, severe cough, and shortness of breath, which often indicates pneumonia.",
      ),
      Constrain(
        test1: "People with COVID-19 are also experiencing neurological symptoms, gastrointestinal (GI) symptoms, or both. These may occur with or without respiratory symptoms.",
      ),
      Constrain(
        test1: "For example, COVID-19 affects brain function in some people. Specific neurological symptoms seen in people with COVID-19 include loss of smell, inability to taste, muscle weakness, tingling or numbness in the hands and feet, dizziness, confusion, delirium, seizures, and stroke.",
      ),
      Constrain(
        test1: "In addition, some people have gastrointestinal (GI) symptoms, such as loss of appetite, nausea, vomiting, diarrhea, and abdominal pain or discomfort associated with COVID-19. These symptoms might start before other symptoms such as fever, body ache, and cough. The virus that causes COVID-19 has also been detected in stool, which reinforces the importance of hand washing after every visit to the bathroom and regularly disinfecting bathroom fixtures.",
      )
    ];
  }
}
