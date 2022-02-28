sortSkills(List<Map> skillsList) {
  skillsList.sort((mp1, mp2) {
    return (mp1['name'].compareTo(mp2['name']));
  });
  return skillsList;
}