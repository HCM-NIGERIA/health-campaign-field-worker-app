home="$PWD"

dart pub global activate mason_cli
dart pub global activate melos

melos.bat run generate-hooks

mason.bat add digit_entity --path ./mason_templates/digit_entity -g
mason.bat add freezed_bloc --path ./mason_templates/freezed_bloc -g

cd apps/health_campaign_field_worker_app/lib || exit
app_root="$PWD"

cd models/model_configs || exit

for file in *.json ; do
  echo "$file"
  mason.bat make digit_entity -c "$file" --on-conflict overwrite -o "$app_root"
done

cd "$home" || exit
echo "$PWD"

melos.bat clean
melos.bat bootstrap

cd tools || exit

# To add localization and bloc skeleton and add repository imports to network_provider_wrapper file navigate to tools directory and run respective package_files.dart which ever you need