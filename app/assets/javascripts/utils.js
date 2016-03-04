amountFormat = function(amount) {
  return formatter.format(Number(amount));
}

dateFormat = function(d) {
  var parts = d.split('-');
  var date =  new Date(parts[0], parts[1]-1, parts[2]); // Note: months are 0-based
  return date.toLocaleDateString("pt-BR")
}

var formatter = new Intl.NumberFormat('pt-BR', {
  style: 'currency',
  currency: 'BRL',
  minimumFractionDigits: 2,
});