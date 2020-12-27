
$(function(){
  function eventCalendar() {
    return $('#calendar').fullCalendar({});
  }

  function clearCalendar() {
    $('#calendar').html('');
  }


  $(document).on('turbolinks:load', function() {
    eventCalendar({});
  });

  // events/index.htmlのinputタグの値をuser_idに代入
  var user_id = $('.events_user').val();

  $('#calendar').fullCalendar({
    events: `/users/${user_id}/events/index.json`,
    titleFormat: 'YYYY年M月',

    // initialView: 'dayGridMonth',
    // initialView: 'timeGridWeek',

    // initialView: 'timeGridDay',
    selectable: true,

    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],

    headerToolbar: {
      left: 'month, week, day',
      center: 'title',
      right: 'today, prev, next',
    },

    buttonText: {
      // dayGridMonth: '月',
      // timeGridWeek: '週',
      // timeGridDay: '日',
      today: '今日',
      prev: '前月',
      next: '翌月'
    },

  　eventColor: '#136FFF',

  　eventTextColor: 'white',

    eventTimeFormat: 'HH:mm',

  })
});