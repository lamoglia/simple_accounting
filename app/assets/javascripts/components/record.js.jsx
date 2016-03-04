var Record = React.createClass({
    getInitialState: function(){
      return {
        edit: false
      };
    },
    handleToggle: function(e) {
      e.preventDefault();
      return this.setState({
        edit: !this.state.edit
      });
    },
    total: function() {
      return this.props.record.stay + this.props.record.consumption;
    },
    handleEdit: function(e) {
      //todo: validate the data.
      var data;
      e.preventDefault();
      data = {
        date: this.props.date,
        stay: ReactDOM.findDOMNode(this.refs.stay).value,
        consumption: ReactDOM.findDOMNode(this.refs.consumption).value
      };
      return $.ajax({
        method: 'PUT',
        url: "/records/" + this.props.record.id,
        dataType: 'JSON',
        data: {
          record: data
        },
        success: (function(_this) {
          return function(data) {
            _this.setState({
              edit: false
            });
            return _this.props.handleEditRecord(_this.props.record, data);
          };
        })(this)
      });
    },
    recordRow: function () {
      return <tr onClick={this.handleToggle}>
                <td>{dateFormat(this.props.record.date)}</td>
                <td>{amountFormat(this.props.record.stay)}</td>
                <td>{amountFormat(this.props.record.consumption)}</td>
                <td>{amountFormat(this.total())}</td>
                <td>
                  <a className="btn btn-default" onClick={this.handleToggle}>
                    <span className="glyphicon glyphicon-pencil" ariaHidden="true" title="Edit"></span>
                  </a>
                </td>
            </tr>;
    },
    recordForm: function() {
      return <tr>
                <td>{dateFormat(this.props.record.date)}</td>
                <td><input className="form-control" type="number" defaultValue={this.props.record.stay} ref="stay"></input></td>
                <td><input className="form-control" type="number" defaultValue={this.props.record.consumption} ref="consumption"></input></td>
                <td>{amountFormat(this.total())}</td>
                <td>
                  <a className="btn btn-success" onClick={this.handleEdit}>
                    <span className="glyphicon glyphicon-ok" ariaHidden="true" title="Update"></span>
                  </a>
                  <a className="btn btn-danger" onClick={this.handleToggle}>
                    <span className="glyphicon glyphicon-remove" ariaHidden="true" title="Undo"></span>
                  </a>
                </td>
            </tr>;
    },
    render: function() {
      if (this.state.edit) {
        return this.recordForm();
      } else {
        return this.recordRow();
      }
    }
});