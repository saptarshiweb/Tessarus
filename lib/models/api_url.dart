//Volunteer Requests
// ignore_for_file: non_constant_identifier_names

//server Urls
String prodserver = '''https://tessarus.gdsckgec.in/''';
String testserver = '''https://tessarus-staging.gdsckgec.in/''';
String server = testserver;

String volunteer_login = '''${server}api/volunteers/login'''; //POST
String all_volunteer = '''${server}api/volunteers/all'''; //GET
String add_volunteer = '''${server}api/volunteers/add'''; //POST
String all_user = '''${server}api/volunteers/allusers'''; //GET
String all_logs = '''${server}api/volunteers/alllogs'''; //GET
String payment_logs = '''${server}api/volunteers/allpaymentlogs'''; //GET

//Add Coins
String add_coin = '''${server}api/volunteers/addcoins'''; //POST

//details of volunteer

String single_volunteer = '''${server}api/volunteers/[volunteer id]'''; //GET
String remove_volunteer = '''${server}api/volunteers/'''; //DELETE
String edit_volunteer = '''${server}api/volunteers/[volunteer_id]'''; //PUT

//with token---------------------

//Event-----------------------------------------------------------
String add_event = '''${server}api/events/add'''; //POST
String update_event = '''${server}api/events/[event_id]'''; //PUT
String add_event_image = '''${server}api/events/images/[event_id]'''; //POST
String delete_event = '''${server}api/events/images/[event_id]'''; //DELETE
String all_event_url = '${server}api/events/all'; //GET
String specific_event = '${server}api/events/'; //GET

//QR Scan
String user_qr_scan = '''${server}api/volunteers/userqrscan'''; //POST

//Ticket Scan
String fetch_ticket_url = '''${server}api/tickets/''';
