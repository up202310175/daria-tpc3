import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerup_tpc3/models/powerbank.dart';
import 'package:powerup_tpc3/screens/map_screen.dart';

void main() {
  Future<void> pumpMapScreen(
    WidgetTester tester,
    List<PowerBank> powerBanks,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MapScreen(powerBanks: powerBanks),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('Feature: Reserve a PowerBank before arriving', () {
    testWidgets('Scenario 1: Successful reservation', (tester) async {
      final powerBanks = [
        PowerBank(
          id: '#102',
          batteryPercent: 85,
          stationName: 'Station #5',
          status: PowerBankStatus.available,
        ),
      ];

      await pumpMapScreen(tester, powerBanks);

      expect(find.text('PowerBank #102'), findsOneWidget);
      expect(find.text('Battery: 85%'), findsOneWidget);
      expect(find.text('Status: Available'), findsOneWidget);

      await tester.tap(find.byKey(const Key('reserveButton_0')));
      await tester.pumpAndSettle();

      expect(find.text('PowerBank Reserved!'), findsOneWidget);
      expect(find.byKey(const Key('reservationTimer')), findsOneWidget);
      expect(find.byKey(const Key('timerValue')), findsOneWidget);
      expect(find.text('10:00'), findsOneWidget);
    });

    testWidgets(
      'Scenario 2: Reservation expires and PowerBank becomes available again',
      (tester) async {
        final powerBanks = [
          PowerBank(
            id: '#205',
            batteryPercent: 42,
            stationName: 'Station #3',
            status: PowerBankStatus.available,
          ),
        ];

        await pumpMapScreen(tester, powerBanks);

        await tester.tap(find.byKey(const Key('reserveButton_0')));
        await tester.pumpAndSettle();

        expect(find.text('PowerBank Reserved!'), findsOneWidget);
        expect(powerBanks[0].status, PowerBankStatus.reserved);

        await tester.pump(const Duration(minutes: 10, seconds: 1));
        await tester.pumpAndSettle();

        expect(powerBanks[0].status, PowerBankStatus.available);
        expect(find.text('PowerBank #205'), findsOneWidget);
        expect(find.text('Status: Available'), findsOneWidget);
      },
    );

    testWidgets('Scenario 3: Reservation unavailable', (tester) async {
      final powerBanks = [
        PowerBank(
          id: '#078',
          batteryPercent: 90,
          stationName: 'Station #1',
          status: PowerBankStatus.reserved,
        ),
      ];

      await pumpMapScreen(tester, powerBanks);

      expect(find.text('PowerBank #078'), findsOneWidget);
      expect(find.text('Status: Reserved'), findsOneWidget);

      await tester.tap(find.byKey(const Key('reserveButton_0')));
      await tester.pumpAndSettle();

      expect(find.text('PowerBank Unavailable'), findsOneWidget);
      expect(
        find.text(
          'This PowerBank has already been reserved by another user.\nPlease choose another station.',
        ),
        findsOneWidget,
      );
      expect(find.text('Find Another PowerBank'), findsOneWidget);
    });

    testWidgets('Map displays available PowerBanks', (tester) async {
      final powerBanks = [
        PowerBank(
          id: '#102',
          batteryPercent: 85,
          stationName: 'Station #5',
          status: PowerBankStatus.available,
        ),
        PowerBank(
          id: '#205',
          batteryPercent: 42,
          stationName: 'Station #3',
          status: PowerBankStatus.available,
        ),
        PowerBank(
          id: '#078',
          batteryPercent: 90,
          stationName: 'Station #1',
          status: PowerBankStatus.reserved,
        ),
      ];

      await pumpMapScreen(tester, powerBanks);

      expect(find.byKey(const Key('mapArea')), findsOneWidget);
      expect(find.text('PowerBank #102'), findsOneWidget);
      expect(find.text('PowerBank #205'), findsOneWidget);
      expect(find.text('Status: Available'), findsNWidgets(2));

      expect(powerBanks.length, 3);
      expect(
        powerBanks.where((pb) => pb.status == PowerBankStatus.reserved).length,
        1,
      );
    });
  });
}