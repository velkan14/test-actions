echo "========== check paths of modified files =========="
git diff --name-only ${{ github.event.pull_request.head.ref }} ${{ github.event.pull_request.base.ref }} > files.txt
while IFS= read -r file
    do
    echo $file
    if [[ $file ==  "__test__"* ]] || [[ $file ==  "/pages/api/v1"* ]] || [[ $file ==  "/lib/middleware"* ]]; then
        echo "This modified file is under the '__test__' or '/pages/api/v1' or '/lib/middleware' folders."
        echo "::set-output name=run_job::true"
        break
    else
        echo "::set-output name=run_job::false"
    fi
done < files.txt