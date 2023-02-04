//Volunteer Requests
// ignore_for_file: non_constant_identifier_names

String volunteer_login =
    '''https://tessarus.gdsckgec.in/api/volunteers/login'''; //POST
String all_volunteer =
    '''https://tessarus.gdsckgec.in/api/volunteers/all'''; //GET
String add_volunteer =
    '''https://tessarus.gdsckgec.in/api/volunteers/add'''; //POST
String all_user =
    '''https://tessarus.gdsckgec.in/api/volunteers/allusers'''; //GET
String all_logs =
    '''https://tessarus.gdsckgec.in/api/volunteers/alllogs'''; //GET
String payment_logs =
    '''https://tessarus.gdsckgec.in/api/volunteers/allpaymentlogs'''; //GET

//Add Coins
String add_coin =
    '''https://tessarus.gdsckgec.in/api/volunteers/addcoins'''; //POST

//details of volunteer

String single_volunteer =
    '''https://tessarus.gdsckgec.in/api/volunteers/[volunteer id]'''; //GET
String remove_volunteer =
    '''https://tessarus.gdsckgec.in/api/volunteers/'''; //DELETE
String edit_volunteer =
    '''https://tessarus.gdsckgec.in/api/volunteers/[volunteer_id]'''; //PUT

//with token---------------------

//Event-----------------------------------------------------------
String add_event = '''https://tessarus.gdsckgec.in/api/events/add'''; //POST
String update_event =
    '''https://tessarus.gdsckgec.in/api/events/[event_id]'''; //PUT
String add_event_image =
    '''https://tessarus.gdsckgec.in/api/events/images/[event_id]'''; //POST
String delete_event =
    '''https://tessarus.gdsckgec.in/api/events/images/[event_id]'''; //DELETE
String all_event_url = 'https://tessarus.gdsckgec.in/api/events/all'; //GET
String specific_event = 'https://tessarus.gdsckgec.in/api/events/';//GET

//QR Scan
String user_qr_scan =
    '''https://tessarus.gdsckgec.in/api/volunteers/userqrscan''';//POST
