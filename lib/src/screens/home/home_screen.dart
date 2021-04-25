import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/home_account_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/location_header_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_accept_user_request_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_arrived_service_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_cancel_status_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_incomming_request_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_invoice.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_rating_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_started_service_widget.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/slider_button_widget.dart';
import 'package:glinkwok_provider/src/screens/menu/menu_screen.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simplest/simplest.dart';

class HomeScreen extends CubitWidget<HomeCubit, HomeState> {
  static provider() => BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(),
        child: HomeScreen(),
      );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController _mapController;
  final PanelController _panelController = PanelController();
  final BorderRadiusGeometry _radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.setup();
    bloc.getCancelReason();
  }

  @override
  Widget builder(BuildContext context, HomeState state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.my_location_rounded,
                size: 36,
              ),
              onPressed: () => _moveToPosition(),
            ),
          )
        ],
      ),
      drawer: MenuScreen.provider(),
      key: _scaffoldKey,
      body: _buildBody(context, state),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
        backgroundColor: primaryColor,
        child: Icon(Icons.menu),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    return AppProgressHUB(
      inAsyncCall: state.isShowLoading,
      child: SlidingUpPanel(
        color: Colors.transparent,
        boxShadow: [],
        maxHeight: _pannelHeight(context, state),
        minHeight: 70,
        controller: _panelController,
        isDraggable: !state.isShowSlider,
        panelSnapping: !state.isShowSlider,
        defaultPanelState: PanelState.OPEN,
        body: _body(context, state),
        panel: _panel(context, state),
      ),
      // child: _contentWidgetFor(state),
    );
  }

  Widget _body(BuildContext context, HomeState state) {
    Set<Marker> _markers = _markerByState(state);
    Set<Polyline> _polylines = state.polylines;
    return Stack(
      children: [
        Container(
            child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(bloc.locationService.position.latitude,
                bloc.locationService.position.longitude),
            zoom: 14.4746,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: _markers,
          polylines: _polylines,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            bloc.requestLocation();
          },
        )),
        HomeAccountWidget(),
        Positioned(
          top: 100,
          right: 0,
          left: 0,
          child: LocationHeaderWidget(),
        ),
      ],
    );
  }

  Widget _panel(BuildContext context, HomeState state) {
    if (state.isShowSlider) {
      return LayoutBuilder(builder: (context, constraints) {
        final _maxHeight = constraints.maxHeight;
        final _padding = 40.0;
        final _sliderHeight = 70.0;
        final _topPadding = _maxHeight - _padding - _sliderHeight;
        final _sliderWidth = Get.width - _padding * 2;
        return Container(
          margin: EdgeInsets.only(
            top: _topPadding,
            bottom: _padding,
            left: _padding,
            right: _padding,
          ),
          child: SliderButtonWidet(
            height: _sliderHeight,
            width: _sliderWidth,
            backgroundColor: state.isOffline ? Colors.grey : primaryColor,
            action: () => bloc.toggleProviderStatus(),
            label:
                state.isOffline ? "slide_to_online".tr : 'slide_to_offline'.tr,
          ),
        );
      });
    }
    return _pannelContent(context, state);
  }

  Widget _pannelContent(BuildContext context, HomeState state) {
    Widget bottomWidget = SpinKitCircle(
      color: primaryColor,
    );
    if (state.isShowPanel) {
      final serviceStatus = bloc.tripService.checkStatus;
      switch (serviceStatus) {
        case CheckStatus.searching:
          bottomWidget = PannelIncommingRequest();
          break;
        case CheckStatus.accepted:
        case CheckStatus.started:
          bottomWidget = PannelAcceptUserRequest();
          break;
        case CheckStatus.arrived:
          bottomWidget = PannelArrived();
          break;
        case CheckStatus.pickedup:
          bottomWidget = PannelStartService();
          break;
        case CheckStatus.dropped:
          bottomWidget = PannelInvoice();
          break;
        case CheckStatus.completed:
          bottomWidget = PannelRating();
          break;
        default:
          break;
      }
    }

    return bottomWidget;
  }

  double _pannelHeight(BuildContext context, HomeState state) {
    if (state.isShowSlider) {
      return 110;
    }

    final serviceStatus = bloc.tripService.checkStatus;
    switch (serviceStatus) {
      case CheckStatus.searching:
        return 450;
      case CheckStatus.accepted:
      case CheckStatus.started:
        return 260;
      case CheckStatus.arrived:
        return 260;
      case CheckStatus.pickedup:
        return 260;
      case CheckStatus.dropped:
        return 400;
      case CheckStatus.completed:
        return 460;
      default:
        return 400;
    }
  }

  _moveToPosition({Position position}) {
    if (_mapController == null) {
      return;
    }
    if (position == null) {
      position = bloc.locationService.position;
    }
    final _cameraUpdate =
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
    _mapController.animateCamera(_cameraUpdate);
  }

  @override
  void listener(BuildContext context, HomeState state) {
    super.listener(context, state);

    if (state is HomeUpdateLocation) {
      _moveToPosition(position: state.position);
    }
    if (state is MoveToPositionState) {
      _moveToPosition(position: state.position);
    }

    if (state.isShowSlider) {
      if (_panelController.isAttached) {
        _panelController.open();
      }
    }
  }

  _markerByState(HomeState state) {
    Set<Marker> _markers = {};
    if ((state.tripResponse?.requests?.length ?? 0) > 0) {
      final _tripRequest = state.tripResponse.requests.first;
      final icon = BitmapDescriptor.defaultMarker;
      final sMarker = Marker(
          markerId: MarkerId(
            _tripRequest.requestId.toString(),
          ),
          position: LatLng(
              _tripRequest.detail.sLatitude, _tripRequest.detail.sLongitude),
          icon: icon);
      _markers.add(sMarker);
    }
    return _markers;
  }
}
