/// Every user-visible string in one place. Replace with GetX translations
/// (`Get.translations`) or `flutter_localizations` when adding more languages.
class AppStrings {
  AppStrings._();

  // General
  static const String appName = 'AEROVA';
  static const String tagline = 'FLY BEYOND ORDINARY';
  static const String tapToContinue = 'Tap to continue';
  static const String splashFooter = 'Powered by Aerova Labs';
  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String getStarted = 'Get started';
  static const String back = 'Back';
  static const String cancel = 'Cancel';
  static const String continueLabel = 'Continue';
  static const String retry = 'Try again';
  static const String share = 'Share';
  static const String pay = 'Pay';
  static const String status = 'Status';
  static const String min = 'min';
  static const String minutes = 'minutes';
  static const String total = 'Total';

  // Onboarding
  static const String onb1Title = 'Find the best flights, fast';
  static const String onb1Body = 'Compare airlines, fares and timings in one place and book in a few taps.';
  static const String onb2Title = 'Pick your seat, pay your way';
  static const String onb2Body = 'Choose the exact seat you want and pay with UPI, card or net banking.';
  static const String onb3Title = 'Track every flight live';
  static const String onb3Body = 'Get gate changes, delays and live map updates right on your phone.';

  // Navigation
  static const String navHome = 'Home';
  static const String navTrips = 'Trips';
  static const String navStatus = 'Status';
  static const String navProfile = 'Profile';

  // Errors
  static const String errTitle = 'Something went wrong';
  static const String errTimeout = 'The request timed out. Please try again.';
  static const String errNoInternet = 'No internet connection.';
  static const String errCancelled = 'Request was cancelled.';
  static const String errServer = 'Server error. Please try again later.';
  static const String errGeneric = 'Something went wrong. Please try again.';
  static const String errUpi = 'Enter a valid UPI ID, e.g. name@bank';
  static const String errCardNumber = 'Enter a valid card number';
  static const String errCardExpiry = 'Enter expiry as MM/YY';
  static const String errCardCvv = 'Enter a valid CVV';
  static const String checkDetails = 'Check your details';
  static const String paymentFailed = 'Payment failed';

  // Home
  static const String goodMorning = 'Good morning';
  static const String goodAfternoon = 'Good afternoon';
  static const String goodEvening = 'Good evening';
  static const String whereToNext = 'Where to next?';
  static const String oneWay = 'One way';
  static const String roundTrip = 'Round trip';
  static const String multiCity = 'Multi-city';
  static const String from = 'From';
  static const String to = 'To';
  static const String departure = 'Departure';
  static const String travellers = 'Travellers';
  static const String searchFlights = 'Search flights';
  static const String specialOffers = 'Special offers';
  static const String popularDestinations = 'Popular destinations';
  static const String viewAll = 'View all';
  static const String flightStatus = 'Flight status';
  static const String myTrips = 'My trips';
  static const String airportGuide = 'Airport guide';
  static const String liveMap = 'Live map';

  // Search
  static const String adult = 'Adult';
  static const String flightsFound = 'flights found';
  static const String noFlights = 'No flights match this filter';
  static const String filterCheapest = 'Cheapest';
  static const String filterFastest = 'Fastest';
  static const String filterMorning = 'Morning';
  static const String filterRefundable = 'Refundable';
  static const String nonStop = 'Non-stop';
  static const String stop = 'stop';
  static const String checkInBag = 'Check-in';

  // Flight details
  static const String flightDetails = 'Flight details';
  static const String baggage = 'Baggage';
  static const String cabinBag = 'Cabin';
  static const String amenities = 'Amenities';
  static const String amenityWifi = 'Wi-Fi';
  static const String amenityMeal = 'Meal';
  static const String amenityPower = 'Power';
  static const String amenityEntertainment = 'Movies';
  static const String fareBreakdown = 'Fare breakdown';
  static const String baseFare = 'Base fare';
  static const String taxes = 'Taxes';
  static const String fuelSurcharge = 'Fuel surcharge';
  static const String convenienceFee = 'Convenience fee';
  static const String taxesAndFees = 'Taxes & fees';
  static const String refundableUpTo = 'Refundable up to';
  static const String selectSeat = 'Select seat';
  static const String terminal = 'Terminal';

  // Seats
  static const String seat = 'Seat';
  static const String noSeatSelected = 'No seat selected';
  static const String pickSeatTitle = 'Pick a seat';
  static const String pickSeatBody = 'Please choose a seat to continue.';
  static const String seatAvailable = 'Available';
  static const String seatPremium = 'Premium';
  static const String seatSelected = 'Selected';
  static const String seatTaken = 'Taken';

  // Payment
  static const String payment = 'Payment';
  static const String securePayment = '100% secure payment';
  static const String fareSummary = 'Fare summary';
  static const String payUsing = 'PAY USING';
  static const String upi = 'UPI';
  static const String upiSubtitle = 'Google Pay, PhonePe, Paytm';
  static const String upiHint = 'yourname@bank';
  static const String cards = 'Cards';
  static const String cardsSubtitle = 'Credit or debit card';
  static const String cardNumber = 'Card number';
  static const String cardExpiry = 'MM/YY';
  static const String cardCvv = 'CVV';
  static const String netBanking = 'Net banking';
  static const String netBankingSubtitle = 'All major banks';

  // Boarding pass
  static const String boardingPass = 'Boarding pass';
  static const String bookingConfirmed = 'Booking confirmed';
  static const String confirmed = 'Confirmed';
  static const String passenger = 'Passenger';
  static const String pnr = 'PNR';
  static const String gate = 'Gate';
  static const String boarding = 'Boarding';
  static const String group = 'Group';
  static const String cabin = 'Cabin';
  static const String scanAtGate = 'Scan at the gate';
  static const String addToWallet = 'Add to wallet';
  static const String walletTitle = 'Added';
  static const String walletBody = 'Boarding pass saved to your wallet.';
  static const String shareTitle = 'Share';
  static const String shareBody = 'Sharing is not wired up in this demo.';
  static const String viewAirportGuide = 'View airport guide';

  // My trips
  static const String upcoming = 'Upcoming';
  static const String completed = 'Completed';
  static const String cancelled = 'Cancelled';
  static const String noTrips = 'No trips here yet';
  static const String changeFlight = 'Change flight';
  static const String addBaggage = 'Add baggage';
  static const String baggage5 = '+5 kg';
  static const String baggage10 = '+10 kg';
  static const String baggage15 = '+15 kg';
  static const String baggageAdded = 'Baggage added';
  static const String cancelTrip = 'Cancel trip';
  static const String keepTrip = 'Keep trip';
  static const String cancelTripTitle = 'Cancel this trip?';
  static const String cancelTripBody = 'Refund rules of your fare will apply.';
  static const String tripCancelled = 'Trip cancelled';

  // Flight status
  static const String statusSearchHint = 'Flight no. or route';
  static const String noStatus = 'No flights found';
  static const String statusOnTime = 'On time';
  static const String statusDelayed = 'Delayed';
  static const String statusCancelled = 'Cancelled';
  static const String delayedBy = 'Delayed by';
  static const String cancelledBanner = 'This flight has been cancelled. Please rebook or request a refund.';
  static const String rebook = 'Rebook';
  static const String trackOnMap = 'Track on map';

  // Airport guide
  static const String walk = 'Walk';
  static const String security = 'Security';
  static const String lounges = 'Lounges';
  static const String transport = 'Transport';
  static const String foodAndDrink = 'Food & drink';

  // Live map
  static const String inAir = 'In air';
  static const String departed = 'Departed';
  static const String arrives = 'Arrives';
  static const String eta = 'ETA';
  static const String altitude = 'Altitude';
  static const String speed = 'Speed';

  // Notifications
  static const String notifications = 'Notifications';
  static const String markAllRead = 'Mark all read';
  static const String filterAll = 'All';
  static const String filterTravel = 'Travel';
  static const String filterBookings = 'Bookings';
  static const String today = 'TODAY';
  static const String earlier = 'EARLIER';
  static const String noNotifications = 'You\'re all caught up';

  // Profile
  static const String account = 'ACCOUNT';
  static const String preferences = 'PREFERENCES';
  static const String personalInfo = 'Personal info';
  static const String savedPassengers = 'Saved passengers';
  static const String paymentMethods = 'Payment methods';
  static const String pushAlerts = 'Push alerts';
  static const String emailUpdates = 'Email updates';
  static const String biometric = 'Biometric unlock';
  static const String darkMode = 'Dark mode';
  static const String helpSupport = 'Help & support';
  static const String logout = 'Log out';
  static const String logoutTitle = 'Log out?';
  static const String logoutBody = 'You will need to sign in again.';
  static const String points = 'points';
  static const String trips = 'Trips';
  static const String miles = 'Miles';
  static const String countries = 'Countries';
  static const String comingSoon = 'Coming soon';
  static const String comingSoonBody = 'This section is not part of the demo yet.';
}
