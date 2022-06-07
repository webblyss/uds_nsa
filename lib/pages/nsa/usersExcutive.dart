List aims = [
  "To seek and promote the interest and the general welfare of all Nursing Students in the Nursing Department.",
  "To establish an effective channel of communication and promote healthy relationships among members of NSA-UDS, the University Authorities and other Associations.",
  "To ensure the advancement of nursing knowledge towards the development of our society through outreach programmes, seminars, symposia, exchange programmes,journals, magazines, research, etc.",
  "To organize and participate in programs that seeks to promote the health and wellbeing of the people within the University, country and the global society as a whole.",
  "To partake in global discussion about health and promote the image and interest of"
];

class Exec {
  String executive;
  List function;
  Exec({
    this.executive,
    this.function,
  });
  static List<Exec> getExec() {
    return <Exec>[
      Exec(executive: "General Assembly",
       function: [
        "Be the highest decision-making body of the NSA and all issues concerning students shall be decided at the General Assembly;",
        "Approve the appointment of committee(s) and sub-committee members Constitute body to vet committee and sub-committee members",
        "Approve budget statement submitted by the Finance Committee;",
        "Approve and help implement programmes, projects and decisions of the Executive board and other Committee(s)",
        "Accept and deliberate on audit report.",
        "Annual dues and other levies shall be submitted to the G.A for the approval.",
      ]),
      Exec(executive: "Executive Board", function: [
        "The executive board shall be responsible for the day to day activities of NSA-UDS",
        "They shall recommend policies for debate and discussion for approval and adoption.",
        "They shall perform any other function assign by the General Assembly",
        "They shall review or ratify decisions and actions of the various committees.",
      ]),
      Exec(executive: "Judicial Board", function: [
        "All matters relating to the enforcement or interpretation of this constitution.",
        "The Judicial Board shall have jurisdiction in all election matters.",
        "All electoral petitions pertaining to the outcome of results shall be lodged to the Judiciary Board within 24 hours after voting results has been declared.",
        "A person aggrieved by the ruling of the J.B shall have the right to make appeal to J.B for consideration within 10 days.",
        "The ruling of the JB shall be precedent on matters in which the constitution is silent, until a provision is enacted to that effect.",
      ]),
      Exec(
        executive: "Electoral Commission",
        function: [
          "The electoral commissioner and deputy shall be appointed by the president in consultation with the other executives.",
          "The quorum for meetings shall be two-thirds majority.",
          "A person shall not be considered for the appointment as the chairperson of the",
          "committee unless the person has served in this commission for at least one (1) year.",
          "The EC shall be responsible for conducting and supervising all elections of NSA-UDS",
          "Provisional election results are to be announced within 6 hours after close of elections.",
          "Shall declare winners of all elections within the Association.",
          "Shall be responsible for the Sale of NSA-UDS nomination forms for elections.",
          "The Electoral Commission shall make rules in consistence with this constitution"
        ]
      ),
      Exec(
        executive: "Standing Committees (SC)",
        function: [
          "The Organizing committee shall be in-charge of organizing all activities of the association including Sports, Entertainment, Social and Academic programmes. The organizing committee shall alongside any other committee set up shall support its work.",
          "The quorum for meetings shall be two thirds.",
          "The Organizing secretary shall be a member and chairperson of the Organizing Committee."
        ]
      ),
      Exec(
        executive: "Ad-hoc Committee",
        function: [
          "There shall be the formation of Ad-hoc committees by the Executive board and or GA to deal with specific issues.",
          "Their findings and recommendations shall be reported to the executive’s board or GA.",
          "Ad-hoc committees shall be dissolved immediately after the presentation and acceptance of their report."
        ]
      )
    ];
  }
}
