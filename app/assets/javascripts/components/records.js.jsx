// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var Records = React.createClass({
  getInitialState: function () {
    return {
      records: this.props.data,
      month: this.props.month,
      year: this.props.year
    };
  },
  getDefaultProps: function () {
    return {
      records: [],
      month: new Date().getMonth(),
      year: new Date().getFullYear()
    };
  },
  addRecord: function(record) {
    var records = React.addons.update(this.state.records, { $push: [record] })
    return this.setState({
      records: records
    });
  },
  updateRecord: function(record, data) {
    var index, records;
    index = this.state.records.indexOf(record);
    records = React.addons.update(this.state.records, {
      $splice: [[index, 1, data]]
    });
    return this.replaceState({
      records: records
    });
  },
  stay: function() {
    return this.state.records.reduce((function(prev, curr) {
      return prev + parseFloat(curr.stay);
    }), 0);
  },
  consumption: function() {
    return this.state.records.reduce((function(prev, curr) {
      return prev + parseFloat(curr.consumption);
    }), 0);
  },
  total: function() {
    return this.stay() + this.consumption();
  },
  render: function () {
    var record;
    var i, len, ref, results;
    ref = this.state.records;
    results = [];

    for(i = 0, len = ref.length; i < len; i++){
      record = ref[i];
      results.push(<Record key={record.id} record={record} handleDeleteRecord={this.deleteRecord} handleEditRecord={this.updateRecord}/>);
    }

    return  <div className="records">
              <div className="row">
                <AmountBox type="success" amount={this.stay()} text="Total stay"/>
                <AmountBox type="success" amount={this.consumption()} text="Total consumption"/>
                <AmountBox type="info" amount={this.total()} text="Total"/>
              </div>
              <hr/>
              <div className="table-responsive">
                <table className="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th className="col-xs-1">Day</th>
                      <th className="col-xs-3">Stay</th>
                      <th className="col-xs-3">Consumption</th>
                      <th className="col-xs-3">Total</th>
                      <th className="col-xs-2">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {results}
                  </tbody>
                </table>
              </div>
            </div>
    }
});