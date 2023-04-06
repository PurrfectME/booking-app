import 'package:booking_app/screens/reservations/reservations_screen.dart';

class StatusHelper {
  static ReservationStatus toStatus(int status) {
    switch (status) {
      case 1:
        return ReservationStatus.fresh;
      case 2:
        return ReservationStatus.opened;
      case 3:
        return ReservationStatus.waiting;
      case 4:
        return ReservationStatus.cancelled;
      case 5:
        return ReservationStatus.closing;
      case 6:
        return ReservationStatus.closed;
      default:
        return ReservationStatus.none;
    }
  }

  static int fromStatus(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.fresh:
        return 1;
      case ReservationStatus.opened:
        return 2;
      case ReservationStatus.waiting:
        return 3;
      case ReservationStatus.cancelled:
        return 4;
      case ReservationStatus.closing:
        return 5;
      case ReservationStatus.closed:
        return 6;
      default:
        return 0;
    }
  }
}
