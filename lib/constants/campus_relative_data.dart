List<int> supportedCampuses = [16,];

// {
//   campus_id : {
//     'title of the generation': ['begin date of each specific user']
//   }
// }
Map<int, Map<String, List<String>>> generationsBeginDates =
{
  16 : {
    '2018 October':   ['2018-10'],
    '2019 March':     ['2019-03'],
    '2019 October':   ['2019-10'],
    '2021 November':  ['2021-11'],
  }
};

Map<int, Map<String, List<String>>> generationsRanges =
{
  16: {
    '2018 October':   ['2018-10-01T00:00:00.000Z', '2018-11-01T00:00:00.000Z'],
    '2019 March':     ['2019-03-01T00:00:00.000Z', '2019-04-01T00:00:00.000Z'],
    '2019 October':   ['2019-10-01T00:00:00.000Z', '2019-11-01T00:00:00.000Z'],
    '2021 November':  ['2021-11-01T00:00:00.000Z', '2021-12-01T00:00:00.000Z'],
  }
};
