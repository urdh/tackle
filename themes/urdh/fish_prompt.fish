# urdh prompt theme, by Simon Sigurdhsson <http://github.com/urdh/>

# while this is pretty nice it could use the right prompt more.
# also, missing screenshot.

function _urdh_theme_user --description 'Print user name'
    switch $USER
        case root
            printf '%s%s%s' (set_color red) $USER (set_color normal)
        case '*'
            printf '%s' $USER
    end
end

function _urdh_theme_cwd --description 'Print current working directory'
    printf '%s%s%s' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

function _urdh_theme_vcs --description 'Write out the VCS prompt'
    # Shared settings
    _ifnotset _urdh_theme_vcs_color_branch 'black' '--bold'
    _ifnotset _urdh_theme_vcs_color_merging 'red' '--bold'

    # Git prompt settings
    set -g __fish_git_prompt_color_branch $_urdh_theme_vcs_color_branch
    set -g __fish_git_prompt_color_merging $_urdh_theme_vcs_color_merging

    set -ge __fish_git_prompt_showstashstate 
    set -ge __fish_git_prompt_showdirtystate
    set -ge __fish_git_prompt_showuntrackedfiles 
    set -ge __fish_git_prompt_show_informative_status 
    set -ge __fish_git_prompt_showupstream 

    set -ge __fish_git_prompt_shorten_branch_len
    set -ge __fish_git_prompt_shorten_branch_char_suffix

    # Show the prompt!
    set -l ___vcs (vcprompt -f '%n')
    if test -n "$___vcs"
        switch $___vcs
            case 'git'
                __fish_git_prompt '%s'
            case '*'
                set -l ___branch_color (set_color $_urdh_theme_vcs_color_branch)
                set -l ___normal_color (set_color normal)
                set -l ___branch (vcprompt -f '%b')
                printf '%s%s%s' $___branch_color $___branch $___normal_color
        end
    end
end

function fish_prompt --description 'Write out the prompt'
    # precalc some variables
    _ifnotset _urdh_theme_hostname (hostname|cut -d . -f 1)
    # print the prompt
    set -l ___host (printf '%s@%s' (_urdh_theme_user) $_urdh_theme_hostname)
    set -l ___cwd (_urdh_theme_cwd)
    set -l ___vcs (string join ' ' '' (_urdh_theme_vcs))
    printf '%s %s%s> ' $___host $___cwd $___vcs
end
