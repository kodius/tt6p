<template>
  <div class="tile is-ancestor">
    <div class="tile is-4 is-vertical is-parent">
      <article class="tile is-child notification is-warning box">
        <p class="title">Body Stats</p>
        <strong>Weight:</strong> {{ plan.lastWeight }} kg
        <br />
        <strong>Body Fat:</strong> {{ plan.lastBodyFat }}%
        <br />
        <strong>Gender: </strong>{{ plan.gender | humanize }}
        <br />
        <strong>Activity Level:</strong> {{ plan.activityLevel | humanize }}
        <br />
        <br />
        <strong>Target Body Fat: </strong>{{ plan.targetBodyFat }}%
        <br />
        <strong>Target Weight: </strong>{{ plan.targetWeight }} kg
      </article>
      <article class="tile is-child notification is-info">
        <p class="title">Totals</p>
        <strong>Total Deficit:</strong> {{ plan.totalDeficit }} kcal
        <br />
        <strong>Expected Change:</strong> {{ plan.weightChangeExpected }} kg
        <br />
        <strong>Change:</strong> {{ plan.weightChange }} kg
        <br />
        <strong>Weekly Average:</strong> {{ plan.weeklyAverage }} kg
        <br />
      </article>
    </div>
    <div class="tile is-parent">
      <div class="tile is-child box">
        <p class="title">Lean Mass & Calories</p>
        <div class="tile">
          <div class="tile is-child box is-6">
            <p class="title">LBM</p>
            <p class="subtitle">{{ plan.lastLbm }} kg</p>
          </div>
          <div class="tile is-child box is-6">
            <p class="title">TDEE</p>
            <p class="subtitle">{{ plan.tdee }} kcal</p>
          </div>
        </div>
        <div class="tile">
          <div class="tile is-child box is-6 is-success">
            <p class="title">Days Till Sixpack</p>
            <p class="subtitle">{{ plan.daysTillSixpack }} days</p>
          </div>
          <div class="tile is-child box is-6  notification is-success">
            <p class="title">Sixpack Day</p>
            <p class="subtitle">{{ plan.dayOfSixpack }}</p>
          </div>
        </div>
        <div class="tile is-child box is-12 notification">
          <p class="title">Allowed Calories</p>
          <p class="subtitle">{{ plan.totalCalories }} kcal (cutting 20%)</p>
        </div>
        <div class="tile is-child box is-12 notification">
          <div class="has-text-centered columns">
            <div class="is-one-fitfth column">
              <p>Fat</p>
              <div class="button is-large is-rounded" 
                :class="{'is-danger': (plan.fatLost < 0), 'is-success': (plan.fatLost >= 0)}">
                  {{plan.fatLost > 0 ? `-${plan.fatLost}` : `+${plan.fatLost * (-1)}`}} kg
            </div>
            </div>
            <div class="is-one-fitfth column">
              <p>LBM</p>
              <a class="button is-large is-rounded" 
                :class="{'is-danger': (plan.lbmDiff < 0), 'is-success': (plan.lbmDiff >= 0)}">
                  {{plan.lbmDiff > 0 ? '+' : ''}}{{plan.lbmDiff}} kg
              </a>
            </div>
            <div class="is-one-fitfth column">
              <p>Streak</p>
              <a class="button is-success is-large is-rounded">{{plan.daysStreak}} {{plan.daysStreak | pluralize('day')}}</a>
            </div>
            <div class="is-one-fitfth column">
              <p>Tracking</p>
              <a class="button is-success is-large is-rounded">{{plan.daysTracked}} {{plan.daysTracked | pluralize('day')}}</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import humanizeString from 'humanize-string';

  export default {
    props: ['plan'],
    data: function () {
      return {}
    },
    filters: {
        humanize(text) {
        return humanizeString(text);
        }
    },
  }

</script>
