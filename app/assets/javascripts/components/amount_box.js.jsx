var AmountBox = React.createClass({
  render: function() {
    var panel_class_name = "panel panel-" + this.props.type;
    return <div className="col-md-4">
              <div className={panel_class_name}>
                <div className="panel-heading">
                  {this.props.text}
                </div>
                <div className="panel-body">
                  {amountFormat(this.props.amount)}
                </div>
              </div>
            </div>;
  }
});