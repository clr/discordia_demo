module ChartsHelper

  def chart_javascript
<<-JS
$(function () {
    var options = {
        lines: { show: true },
        points: { show: false },
        xaxis: { tickDecimals: 0, tickSize: 1 },
        yaxis: { ticks: 10, min: -1, max: 1 }
    };
    var data = [];
    var placeholder = $("#placeholder");
    var interval = null;
    var params = "";

    $.plot(placeholder, data, options);

    // initiate a recurring data update
    $("button.update").click(function () {
        // reset data
        data = [
          {
            label: 'Attack',
            data: [[-15.0, 0],[-14.75, 0],[-14.5, 0],[-14.25, 0],[-14.0, 0],[-13.75, 0],[-13.5, 0],[-13.25, 0],[-13.0, 0],[-12.75, 0],[-12.5, 0],[-12.25, 0],[-12.0, 0],[-11.75, 0],[-11.5, 0],[-11.25, 0],[-11.0, 0],[-10.75, 0],[-10.5, 0],[-10.25, 0],[-10.0, 0],[-9.75, 0],[-9.5, 0],[-9.25, 0],[-9.0, 0],[-8.75, 0],[-8.5, 0],[-8.25, 0],[-8.0, 0],[-7.75, 0],[-7.5, 0],[-7.25, 0],[-7.0, 0],[-6.75, 0],[-6.5, 0],[-6.25, 0],[-6.0, 0],[-5.75, 0],[-5.5, 0],[-5.25, 0],[-5.0, 0],[-4.75, 0],[-4.5, 0],[-4.25, 0],[-4.0, 0],[-3.75, 0],[-3.5, 0],[-3.25, 0],[-3.0, 0],[-2.75, 0],[-2.5, 0],[-2.25, 0],[-2.0, 0],[-1.75, 0],[-1.5, 0],[-1.25, 0],[-1.0, 0],[-0.75, 0],[-0.5, 0],[-0.25, 0],[0.0, 0]]
          }
        ];
        
        $.plot(placeholder, data, options);

        interval = setInterval(fetchData, 250);
    });

    // stop the ajaxes
    $("button.stop").click(function(){
      clearInterval(interval);
    });

    // send a hit param
    $("button.hit").click(function(){
      clearInterval(interval);
      params = "?hit=true";
      interval = setInterval(fetchData, 250);
    });


    function fetchData() {

        function onDataReceived(series) {
            // we get all the data in one go, if we only got partial
            // data, we could merge it with what we already got
            $(data).each(function(i,line){
              line.data.shift();
              line.data.push([1,series[line.label][0]]);
              $(line.data).each(function(j,set){
                set[0] = set[0] - 0.25;
              });
            });
            
            $.plot($("#placeholder"), data, options);
            params = "";
        }
    
        $.ajax({
            // usually, we'll just call the same URL, a script
            // connected to a database, but in this case we only
            // have static example files so we need to modify the
            // URL
            url: "chart"+params,
            method: 'GET',
            dataType: 'json',
            success: onDataReceived
        });
    }
});
JS
  end
end
