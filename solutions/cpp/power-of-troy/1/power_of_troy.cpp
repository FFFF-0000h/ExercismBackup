#include "power_of_troy.h"

namespace troy {


    void give_new_artifact(human &owner, const std::string &artifactName)
    {
        owner.possession = std::make_unique<artifact>(artifactName);
    }

    void exchange_artifacts(std::unique_ptr<artifact> &first, std::unique_ptr<artifact> &second)
    {
        first.swap(second);
    }

    void manifest_power(human &owner, const std::string &powerName)
    {
        owner.own_power = std::make_shared<power>(powerName);
    }

    void use_power(const human &owner, human &target)
    {
        target.influenced_by = owner.own_power;
    }

    int power_intensity(const human &owner)
    {
        return owner.own_power.use_count();
    }
}  // namespace troy