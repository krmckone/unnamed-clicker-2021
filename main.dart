import 'dart:async';
// Need to convert the time to a generalized counter from 0
// (years,months,days,minutes,seconds)
// Need to advance time in a separate isolate
// and pass the next time as a message on a pipe/stream

var ticker = DateTime.now();
const timeout = Duration(seconds: 1);
const timeTick = Duration(seconds: 5);
var timeHandlers = Map<String, Function>();
void main(List<String> args) {
  registerTime('6:25:7:1:50', () => {print('time')});
  Timer.periodic(timeout, handleTimeInterval);
}

void handleTimeInterval(Timer t) {
  ticker = advanceTime();
  var time = makeTimeStr(ticker);
  timeHandlers[time]!();
  print(time);
}

String makeTimeStr(DateTime dt) {
  var month = dt.month;
  var day = dt.day;
  var hour = dt.hour;
  var minute = dt.minute;
  var second = dt.second;
  return '$month:$day:$hour:$minute:$second';
}

DateTime advanceTime() {
  return ticker.add(timeTick);
}

void registerTime(String t, Function f) {
  timeHandlers[t] = f;
}
