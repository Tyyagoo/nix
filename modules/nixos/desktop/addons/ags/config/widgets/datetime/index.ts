const date = Variable('', {
  poll: [1000, 'date'],
})

const fullWeekDay = {
  "seg": "Segunda",
  "ter": "Terça",
  "qua": "Quarta",
  "qui": "Quinta",
  "sex": "Sexta",
  "sab": "Sábado",
  "dom": "Domingo",
}

const capitalize = (str: string) => str[0].toUpperCase() + str.slice(1);

function prettify(dt: string) {
  const [weekDay, day, month, _year, time, _gmt] = dt.split(" ")
  return `  ${time}   ${fullWeekDay[weekDay]} ${day} ${capitalize(month)}`
}

export default function DateTime() {
  return Widget.Label({
    label: date.bind().as(prettify)
  })
}
