
IR.controller({
    "pickerData" : [
        ['1-a', '1-b', '1-c'],
        ['2-a', '2-b', '2-c']
    ],
    "pickerRowSelected" : function (pickerView, row, component, data) {
        NSLog('pickerView='+pickerView+', row='+row+', component='+component+", data="+data);
    }
});