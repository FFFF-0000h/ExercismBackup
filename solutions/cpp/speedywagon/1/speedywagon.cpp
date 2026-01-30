#include "speedywagon.h"

namespace speedywagon {

// Enter your code below:

// Please don't change the interface of the uv_light_heuristic function
int uv_light_heuristic(const std::vector<int>* data_array) {
    double avg{};
    for (auto element : *data_array) {
        avg += element;
    }
    avg /= data_array->size();
    int uv_index{};
    for (auto element : *data_array) {
        if (element > avg) ++uv_index;
    }
    return uv_index;
}


bool connection_check(const pillar_men_sensor* ps)
{
  return (ps != nullptr);
}


int activity_counter(const pillar_men_sensor* sensors, size_t dimension) {
  int total_activity{0};
  for (size_t i{0}; i < dimension; ++i) {
    total_activity += sensors[i].activity;
  }
  return total_activity;
}

bool alarm_control(const pillar_men_sensor* ps) {
  return connection_check(ps) && activity_counter(ps, 1) > 0;
}

bool uv_alarm(const pillar_men_sensor* ps) {
  return connection_check(ps) && uv_light_heuristic(&ps->data) > ps->activity;
}


}  // namespace speedywagon