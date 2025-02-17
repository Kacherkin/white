import { BooleanLike } from 'common/react';
import { Box, Button, NumberInput, Flex } from '../../components';
import { classes } from 'common/react';
import { formatMoney, formatSiUnit } from '../../format';
import { useSharedState } from '../../backend';
import { BoxProps } from '../../components/Box';

export const MATERIAL_KEYS = {
  'железо': 'sheet-metal_3',
  'стекло': 'sheet-glass_3',
  'серебро': 'sheet-silver_3',
  'золото': 'sheet-gold_3',
  'алмазы': 'sheet-diamond',
  'плазма': 'sheet-plasma_3',
  'уран': 'sheet-uranium',
  'бананиум': 'sheet-bananium',
  'титан': 'sheet-titanium_3',
  'блюспейс кристалл': 'polycrystal',
  'пластик': 'sheet-plastic_3',
} as const;

export type Material = {
  name: keyof typeof MATERIAL_KEYS;
  ref: string;
  amount: number;
  sheets: number;
  removable: BooleanLike;
};

interface MaterialIconProps extends BoxProps {
  material: keyof typeof MATERIAL_KEYS;
}

export const MaterialIcon = (props: MaterialIconProps) => {
  const { material, ...rest } = props;

  return (
    <Box
      {...rest}
      className={classes(['sheetmaterials32x32', MATERIAL_KEYS[material]])}
    />
  );
};

const EjectMaterial = (
  props: {
    material: Material;
    onEject: (amount: number) => void;
  },
  context
) => {
  const { name, removable, sheets } = props.material;
  const [removeMaterials, setRemoveMaterials] = useSharedState(
    context,
    'remove_mats_' + name,
    1
  );
  if (removeMaterials > 1 && sheets < removeMaterials) {
    setRemoveMaterials(sheets || 1);
  }
  return (
    <>
      <NumberInput
        width="30px"
        animated
        value={removeMaterials}
        minValue={1}
        maxValue={sheets || 1}
        initial={1}
        onDrag={(e, val) => {
          const newVal = parseInt(val, 10);
          if (Number.isInteger(newVal)) {
            setRemoveMaterials(newVal);
          }
        }}
      />
      <Button
        icon="eject"
        disabled={!removable}
        onClick={() => {
          props.onEject(removeMaterials);
        }}
      />
    </>
  );
};

export const Materials = (props: {
  materials: Material[];
  onEject: (ref: string, amount: number) => void;
}) => {
  return (
    <Flex wrap>
      {props.materials.map((material) => (
        <Flex.Item key={material.name} grow={1} shrink={1}>
          <MaterialAmount
            name={material.name}
            amount={material.amount}
            formatting={MaterialFormatting.SIUnits}
          />
          <Box mt={1} textAlign="center">
            <EjectMaterial
              material={material}
              onEject={(amount) => {
                props.onEject(material.ref, amount);
              }}
            />
          </Box>
        </Flex.Item>
      ))}
    </Flex>
  );
};

export enum MaterialFormatting {
  SIUnits,
  Money,
  Locale,
}

export const MaterialAmount = (props: {
  name: keyof typeof MATERIAL_KEYS;
  amount: number;
  formatting?: MaterialFormatting;
  color?: string;
  style?: Record<string, string>;
}) => {
  const { name, amount, color, style } = props;

  let amountDisplay;

  switch (props.formatting) {
    case MaterialFormatting.SIUnits:
      amountDisplay = formatSiUnit(amount, 0);
      break;
    case MaterialFormatting.Money:
      amountDisplay = formatMoney(amount);
      break;
    case MaterialFormatting.Locale:
      amountDisplay = amount.toLocaleString();
      break;
    default:
      amountDisplay = amount;
  }

  return (
    <Flex direction="column" textAlign="center">
      <Flex.Item>
        <MaterialIcon material={name} style={style} />
      </Flex.Item>
      <Flex.Item color={color}>{amountDisplay}</Flex.Item>
    </Flex>
  );
};
