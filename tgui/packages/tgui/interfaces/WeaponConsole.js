import { classes } from 'common/react';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { ByondUi, Section, Box, Divider, ProgressBar, NoticeBox } from '../components';
import { Window } from '../layouts';

export const WeaponConsole = (props, context) => {
  const { act, data, config } = useBackend(context);
  const {
    mapRef,
  } = data;
  return (
    <Window
      theme="flight"
      width={870}
      height={708}
      resizable>
      <Window.Content>
        <div className="WeaponConsole__left">
          <ShipSearchContent />
        </div>
        <div className="WeaponConsole__right">
          <div className="WeaponConsole__weaponpane">
            <WeaponSelection />
          </div>
          <ByondUi
            className="WeaponConsole__map"
            params={{
              id: mapRef,
              type: 'map',
            }} />
        </div>
      </Window.Content>
    </Window>
  );
};

export const WeaponSelection = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    weapons,
  } = data;
  return (
    <Section>
      <div className="WeaponConsole__weaponlist">
        {weapons.map(weapon => (
          <WeaponDisplay
            key={weapon.id}
            weapon={weapon} />
        ))}
      </div>
    </Section>
  );
};

export const WeaponDisplay = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    weapon,
  } = props;

  const [
    selected_weapon,
    set_selected_weapon,
  ] = useLocalState(context, "selected_weapon", 0);

  let style = (1-weapon.cooldownLeft / weapon.cooldown) < 0.3
    ? "#weaponConsole__flash"
    : (1-weapon.cooldownLeft / weapon.cooldown) < 1
      && "weaponConsole__flash_yellow";
  let colour = (1-weapon.cooldownLeft / weapon.cooldown) < 0.3
    ? "#db6969"
    : (1-weapon.cooldownLeft / weapon.cooldown) < 1
      ? "#f5e553"
      : "#8ff288";

  return (
    <Box
      key={weapon.id}
      class={selected_weapon === weapon.id ? "weaponConsole__weapon selected" : "weaponConsole__weapon"}
      onClick={() => {
        set_selected_weapon(weapon.id);
        act('set_weapon_target', {
          id: weapon.id,
        });
      }}>
      <Box width="100px" height="100%">
        <Box
          width={(1-weapon.cooldownLeft / weapon.cooldown) * 80 + "%"}
          height="100%"
          backgroundColor={colour}
          class={style} />
      </Box>
      <Box
        mr={2}
        textAlign="center">
        {weapon.name}
      </Box>
    </Box>
  );
};

export const ShipSearchContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ships = [],
    selectedShip,
    in_flight = false,
  } = data;
  return (
    <Section>
      {!in_flight ? (
        <div class="weaponConsole__alert">
          Параллаксовый радар оффлайн. <br />
          Недостаточно скорости.
        </div>
      ) : ships.length === 0 && (
        <div class="weaponConsole__alert">
          Нет целей.
        </div>
      )}
      {ships && ships.map(ship => (
        <Box
          key={ship.id}
          className={classes([
            'Button',
            'Button--fluid',
            'Button--color--transparent',
            'Button--ellipsis',
            selectedShip
              && selectedShip === ship.id
              && 'Button--selected',
          ])}
          onClick={() => {
            act('target_ship', {
              id: ship.id,
            });
          }}>
          <b>
            {ship.name}{" - "}
          </b>
          {ship.faction}
          <Divider />
          {(ship.critical
            ? (
              <NoticeBox
                textAlign="center">
                !! Реактор повреждён !!
              </NoticeBox>
            )
            : (
              <Fragment>
                <ProgressBar
                  ranges={{
                    good: [0.75, Infinity],
                    average: [0.25, 0.75],
                    bad: [-Infinity, 0.25],
                  }}
                  value={ship.health/ship.maxHealth}>
                  Состояние: {ship.health}
                </ProgressBar>
                <Divider />
                {ship.hostile
                  ? (
                    <NoticeBox
                      textAlign="center"
                      color="red">
                      ВРАГ
                    </NoticeBox>
                  ) : (
                    <NoticeBox
                      textAlign="center"
                      color="green">
                      Нейтрал
                    </NoticeBox>
                  )}
                {ship.id === selectedShip
                  ? (
                    <NoticeBox
                      textAlign="center"
                      color="red">
                      Цель выбрана
                    </NoticeBox>
                  )
                  : (
                    <NoticeBox
                      textAlign="center"
                      color="grey">
                      Выбрать цель
                    </NoticeBox>
                  )}
              </Fragment>
            )
          )}
        </Box>
      ))}
    </Section>
  );
};
