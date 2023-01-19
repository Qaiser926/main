String parseDateTimeToDDMMYYYFormat(DateTime? time) {
  if (time != null) {
    return '${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')}.${time.year}';
  } else {
    return "";
  }
}
