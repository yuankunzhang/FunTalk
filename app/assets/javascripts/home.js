/**
 * Created by yuankun on 21/10/2016.
 */
Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
};

var topics = new Vue({
    el: '#pending-topics',
    data: {
        points: 0,
        topics: [],
        voted_topic_ids: []
    },
    created: function () {
        this.fetchTopics();
    },
    methods: {
        fetchTopics: function () {
            var self = this;
            $.ajax({
                url: '/topics/pending',
                method: 'GET',
                success: function (data) {
                    if (data.s) {
                        self.topics = data.q.topics;
                        self.fetchVotes();
                    }
                },
                error: function (err) {
                    console.error(err);
                }
            });
        },
        fetchVotes: function () {
            var self = this;
            $.ajax({
                url: '/users/info',
                method: 'GET',
                success: function (data) {
                    if (data.s) {
                        self.refreshVoteInfo(data.q);
                    }
                },
                error: function (err) {
                    console.error(err);
                }
            });
        },
        refreshVoteInfo: function (q) {
            this.points = q.points;
            this.voted_topic_ids = [];
            for (var i = 0; i < q.votes.length; i++) {
                this.voted_topic_ids.push(q.votes[i].topic_id);
            }
        },
        is_voted: function (topic_id) {
            return this.voted_topic_ids.indexOf(topic_id) != -1;
        },
        toggleVote: function (event) {
            var target = event.target;
            if (target.tagName.toLowerCase() != 'a') {
                target = target.parentElement;
            }

            var topic_id = target.lastElementChild.value;
            var voted = this.is_voted(parseInt(topic_id));

            if (!voted && this.points === 0) {
                console.log('not enough points');
                return;
            }

            var url = voted ? '/votes/destroy' : '/votes/create';
            var self = this;
            
            $.ajax({
                url: url,
                method: 'POST',
                data: {
                    'topic_id': topic_id
                },
                success: function (data) {
                    if (data.s) {
                        self.refreshVoteInfo(data.q);
                        for (var i = 0; i < self.topics.length; i++) {
                            if (self.topics[i].id == topic_id) {
                                if (voted) {
                                    var idx = self.voted_topic_ids.indexOf(topic_id);
                                    console.log(self.voted_topic_ids);
                                    self.topics[i].vote_count -= 1;
                                } else {
                                    self.topics[i].vote_count += 1;
                                }
                            }
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
    }
});

$(document).ready(function () {
    $('#show-modal').click(function () {
        $('.ui.modal').modal('setting', 'closable', false).modal('show');
    });

    $('.message .close').click(function () {
        $(this).parent().hide('slow');
    });

    $('form#create-topic').form({
        fields: {
            topic_subject: 'empty',
            topic_description: 'empty'
        }
    }).submit(function () {
        var self = $(this);
        var values = self.serialize();
        self.addClass('loading');

        $.ajax({
            type: 'POST',
            url: self.attr('action'),
            data: values
        }).success(function () {
            self.trigger('reset');
            $('.success.message').show();
            topics.fetchTopics();
            self.removeClass('loading');
            $('.ui.modal').modal('hide');
            $('html, body').animate({ scrollTop: 0 }, 'slow');
        }).error(function () {
            self.removeClass('loading');
        });
        return false;
    });

    $('#submit-button').click(function () {
        var f = $('form#create-topic');
        if (f.form('is valid')) {
            f.submit();
        }
        return false;
    });
});

// var votes = <%= raw current_user.votes.to_json %>;
// var voted_topic_ids = [];
// for (var i = 0; i < votes.length; i++) {
//     voted_topic_ids.push(votes[i].topic_id);
// }
//
// var topics = new Vue({
//     el: '#pending-topics',
//     data: {
//         topics: [],
//         voted_topic_ids: voted_topic_ids
//     },
//     created: function () {
//         this.fetch();
//     },
//     attached: function () {
//         console.log('attached');
//     },
//     methods: {
//         fetch: function () {
//             var self = this;
//             $.ajax({
//                 url: '/topics/pending',
//                 method: 'GET',
//                 success: function (data) {
//                     if (data.s) {
//                         self.topics = data.q.topics;
//                     }
//                 },
//                 error: function (err) {
//                     console.error(err);
//                 }
//             });
//         }
//     }
// });
//
// $('#show-modal').click(function () {
//     $('.ui.modal').modal('setting', 'closable', false).modal('show');
// });
//
// $('.message .close').click(function () {
//     $(this).parent().hide('slow');
// });
//
// $('form#create-topic').form({
//     fields: {
//         topic_subject: 'empty',
//         topic_description: 'empty'
//     }
// }).submit(function () {
//     var self = $(this);
//     var values = self.serialize();
//     self.addClass('loading');
//
//     $.ajax({
//         type: 'POST',
//         url: self.attr('action'),
//         data: values
//     }).success(function () {
//         self.trigger('reset');
//         $('.success.message').show();
//         topics.fetch();
//         self.removeClass('loading');
//         $('.ui.modal').modal('hide');
//     }).error(function () {
//         self.removeClass('loading');
//     });
//     return false;
// });
//
// $('#submit-button').click(function () {
//     var f = $('form#create-topic');
//     if (f.form('is valid')) {
//         f.submit();
//     }
//     return false;
// });
//
// function vote(el) {
//     $.ajax({
//         type: 'POST',
//         url: '/votes/create',
//         data: {topic_id: el.value}
//     }).success(function () {
// //      el.className = "ui olive label";
// //      el.lastElementChild.innerHTML = '1';
//     }).error(function () {
//     });
// }
//
// function cancel_vote(el) {
//     $.ajax({
//         type: 'POST',
//         url: '/votes/destroy',
//         data: {topic_id: el.value}
//     }).success(function () {
// //      el.className = "ui label";
// //      el.lastElementChild.innerHTML = '0';
//     }).error(function () {
//     });
// }