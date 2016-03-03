amountFormat = function(amount) {
  return formatter.format(Number(amount));
}

dateFormat = function(d) {
  var date = new Date(d);
  return date.toLocaleDateString("pt-BR")
}

var formatter = new Intl.NumberFormat('pt-BR', {
  style: 'currency',
  currency: 'BRL',
  minimumFractionDigits: 2,
});