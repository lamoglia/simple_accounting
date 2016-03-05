var AmountBox = React.createClass({
  render: function() {
    var panel_class_name = "panel panel-" + this.props.type;
    return <div className="col-sm-4 col-xs-12">
              <div className={panel_class_name}>
                <div className="panel-heading">
                  {this.props.text}
                </div>
                <div className="panel-body">
                  <strong>{amountFormat(this.props.amount)}</strong>
                </div>
              </div>
            </div>;
  }
});